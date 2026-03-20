Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078B3AE1B1
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009484; cv=none; b=MU5TPCRJTKly8aGcKGv83XmJC4E7JJp5PvW94X7P19MZ81YMEpCCmnd9/u8nGhUI3n0HN7PuKHye9jmbifLWlZEfYFOhoX7FedA6zJoI60ufdCMiYPz7XawHXJ5PIKm6pwEj3Cl1d2Yr7reWf2DxwMg5wHGlnFoWqbabV0B+Vrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009484; c=relaxed/simple;
	bh=s3ulHQruHwoZQicSh9bvI5S+LWAgZanSwsttzwbYy+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GXsGIonVVmlXXI+OsHhIrjLHjXOHiYlioh3Oa4Jwb9wTx1/+RypmK1HxSGRAlOSOYUHkzFbXKT3bOTpc/hFPDS6n9QT8z9dsFRRCcT9tbsBFaS8AkVQIaQPbuX9P8D+JxRPRQ5WTGxNzPBxS2miO+kseaL7ay4afgAw03TVBSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfIApSz+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfIApSz+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CCF6C2BC9E
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 12:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774009484;
	bh=s3ulHQruHwoZQicSh9bvI5S+LWAgZanSwsttzwbYy+8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sfIApSz+DL0xUi1UdKsii3fkZAk7ew5DIWO6xP5UzwQ3z+3/ZsoDpnBV9CKnQPu1D
	 Wm82BfASvh65q+p8ulbMnXS4+NlNhtnx1rWiLw3oqGcpsnIRgpOCiDCVSGYH0fEPXQ
	 H5rOF95Pc/9EgD9G/nPu8i+hh+PLwy/ggGpiSMs8md1K2nS2jKP0GoWZF/HrP60uuy
	 6f8Z1959Pm8b/CcgNJ7GkS1lRLhT+hrNFECSPsijuamih8Qx8U7bfgGbKyRKimqQ1f
	 Cv3EwwVFYod8ZjJlooYMM7BX91kt56t/xe7DVaV96NZTbIBxBNU2bFSK/ZQgEtg5Me
	 oKmCQKnhhDJfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0133CC41614; Fri, 20 Mar 2026 12:24:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221256] On Boot - WARNING: kernel/irq/manage.c:1502 at
 __setup_irq+0x5bb/0x800, CPU#7: iio-sensor-prox/932
Date: Fri, 20 Mar 2026 12:24:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221256-217253-mIsIK3CSgF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221256-217253@https.bugzilla.kernel.org/>
References: <bug-221256-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221256

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Could you bisect this? https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
