Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18F3ED5B2
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765735; cv=none; b=ffw9pxI2w7Qstgq1WDbP2mfAzAROUB7PakyuqqSKEpUMpbSK7eSSXFexFYQBQruymqoYqc/I/h0c8SI0FhTA0XQz/lb6F6JHU/IyN5FM9/nsRqgQidbJiF1deHkk9OA4BCl90JhxB75Y4GMVJ/jBBmYlMMTdVVHOWlOV+bnYwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765735; c=relaxed/simple;
	bh=j2p34uYXTTzEh8roj2vh3RgsH7yWCqvpMGu36f7ITQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QF5UukDQGNwtYyFEdR6NAY58Wmp4dTjq6601b7OLp2Kzk8iCSEFuM739z/kUQ+9vH1N0vRXLcLET4P4+ZfwLmZXBZ4xa4kpXBaNg0A/aqTi8/Cvk5xyKVxhKjh+FX/1OVl/jwpxWfJPeJmxD4Sll7dF/PiVsc8jEnTxFndsgF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeA+D5pn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeA+D5pn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D2C3C19424
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 16:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765735;
	bh=j2p34uYXTTzEh8roj2vh3RgsH7yWCqvpMGu36f7ITQ8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YeA+D5pnvqNpkiT7Wue3XVFh7JC+kUlRclgNsLOjgTauAKC4GwtI7+Gi4NJKcun50
	 6b1kxHgmMK8yhT1d+C5ZaB55mcNmiw2yhwh65kAR4xk88sbs0WcKuEwWHr55wycHZg
	 NjDtEJcK7spCu/S4wvx4S/wnQD+qJJ4e6vMr2a5ORPVM+Gi99uvwQyzZPB4Zv25LVw
	 yme5+gykXmOHAViaHYLLuBsYyJmWK4S3SSNTNx3DSwvAQQaUufk2PqvgWmMEU/heyD
	 qT/ffNE42FyW7sUfDXHaOe8Zbgyd8MrGFYpl5bIvNffMNVldaK0572SeNZPvDOQCDi
	 YPF/sPnVnQNTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 30AFCC53BC5; Tue, 17 Mar 2026 16:42:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Tue, 17 Mar 2026 16:42:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jpoimboe@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219192-217253-jQJLtIfc44@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219192-217253@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219192

Josh Poimboeuf (jpoimboe@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jpoimboe@kernel.org

--- Comment #15 from Josh Poimboeuf (jpoimboe@kernel.org) ---
In this case the scoped lock is unconditional, so the unreachable() can jus=
t be
replaced with an " /* unreachable */ " comment.

We're trying to remove all uses of unreachable() from the kernel as they te=
nd
to encourage the compiler to insert undefined behavior.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
