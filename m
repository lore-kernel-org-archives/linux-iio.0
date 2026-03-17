Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60637E315
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770705; cv=none; b=caO8icZ90twtZ/cmPbrelFYbyyFiVhG7qpmj0KB6bO4jwCh1ai/UoizfAQ2eWD6ew5U8oUs8ba1eEXBDyht1MinIPcswVKe9oZKDLtmnksUMlZVxfnO+e8Bi60sjUigBckxz0RQBgaFk4YTTLeG48t9xEErTfZ24T+8wNNTeOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770705; c=relaxed/simple;
	bh=3zmngdi5HjqqveA2w3iyvK43wrgvhTxGVThe9Mpz8Xg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=omWzeRVfMvkvhsTOT46eaG0prEzTwQsAAhfbG357HyOyrYCzhBm6+hE0ZibgQrNXS+C9kyx+jgq1owSX1iA870EbGsIhaEXPZdgFJJ+WdfdW2AEKYkyqdzjFOeQ+YYTEBac5tAcXDKBNXkHGT8moBDIhYQLHDLL2oSeyInv1LJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5Mataii; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5Mataii"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE6F6C4CEF7
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770705;
	bh=3zmngdi5HjqqveA2w3iyvK43wrgvhTxGVThe9Mpz8Xg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h5Mataiij9/29DFHuDaWWEkbUdRVSiLFD08BcYXdhBvdOeEdEv7xYfllnd7IPFR9/
	 n8oImiyWpiCAEr0Ak+nwdXcTrlNMdQy8sLcVNIzNEW/ABJwxahezcYmpNa52deg4ZH
	 E100HQPtgaCz3qpT0VbLmor6pHWQALYm/o4TGuAkEJCKAzufqJEl9N4LYvSpolLfll
	 riVV5Jg/0cwgDRoBIs8Eb7xZVqwiif0sMTurxpDgvEG9D1oaftT6+WeLFD8am9+qux
	 otpt2IJgb0JQ56BAIdE37605LawFzh5Ru7e/UXCubQ0nuhoFSpmnBGgkEhb9Z8hfOO
	 B2eoyFliDrW4Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B71C9C41613; Tue, 17 Mar 2026 18:05:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220772] NULL pointer dereference in bmc150-accel-core
Date: Tue, 17 Mar 2026 18:05:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220772-217253-Gg2Py6X2ZV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220772-217253@https.bugzilla.kernel.org/>
References: <bug-220772-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220772

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
