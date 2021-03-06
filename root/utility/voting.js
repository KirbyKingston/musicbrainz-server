/*
 * @flow strict
 * Copyright (C) 2018 MetaBrainz Foundation
 *
 * This file is part of MusicBrainz, the open internet music database,
 * and is licensed under the GPL version 2, or (at your option) any
 * later version: http://www.gnu.org/licenses/gpl-2.0.txt
 */

export function isInvolved(election: AutoEditorElectionT, user: ?EditorT): void | boolean {
  return !!user && (
    election.proposer.id === user.id ||
    election.candidate.id === user.id ||
    (election.seconder_1 && election.seconder_1.id === user.id) ||
    (election.seconder_2 && election.seconder_2.id === user.id)
  );
}

export function votesVisible(election: AutoEditorElectionT, user: ?EditorT): void | boolean {
  return election.is_closed ||
    (election.is_open && isInvolved(election, user));
}

export function canVote(election: AutoEditorElectionT, user: ?EditorT): boolean {
  return (!!user && election.is_open && user.is_auto_editor &&
    !user.is_bot && !isInvolved(election, user));
}

export function canSecond(election: AutoEditorElectionT, user: ?EditorT): boolean {
  return (!!user && election.is_pending && user.is_auto_editor &&
    !user.is_bot && !isInvolved(election, user));
}

export function canCancel(election: AutoEditorElectionT, user: ?EditorT): boolean {
  return (!!user && !election.is_closed && election.proposer.id === user.id);
}

export function canNominate(nominator: ?EditorT, nominee: ?EditorT): boolean {
  return (!!nominator && !!nominee && nominator.is_auto_editor &&
    !nominee.is_auto_editor && !nominee.deleted);
}
