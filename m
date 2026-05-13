Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B5328B62
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678911; cv=none; b=qlCjrHJtjAZDibUuHNnk6olpEwv2v611Qu9t5ZcLPqWrcRExm0p5JQ/2I8QUJBIeqgMgXfRvJjZHPIRPXmVVCaLka8C+0Op6pPRCpjZqKAYmmsGaiiyy2apnpArTfR7QcFqFVjKrlipeQVyEnavQqN0tCydrjK+IR2/R3ChZL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678911; c=relaxed/simple;
	bh=ELYT3g0HjNB6wRKgboCcCVc/9j18UT6gfKSItQDSkM4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jeYoA7BbOQAAyZhU0MPwlQbHvRbsNck5x0P0gpBKktTSVDYy1OoBaMtvwenFAeQwg1DFgI7dxwrF+Jk8a8BQ444/E2vGRX4hqI168IsC6DI80P+IEb1sh9H4fdrkHexr2WajKs6Ua6e3YowNhQh9ibdYZUZ6JZnnFnKMadkV8ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0WkyOSD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0WkyOSD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C95BC2BCC7
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778678911;
	bh=ELYT3g0HjNB6wRKgboCcCVc/9j18UT6gfKSItQDSkM4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g0WkyOSD28O0U52kcVHsF/T8X4Z6nNx7v4L6u3+DrfXs1VnPxBQ0UCP2xlsEJzzNs
	 113wE7c22llyu7ZeCWaoHsRXYXNSicmSLaK/wL87dobBklF5pl3exsILp3zghvBKLM
	 T3cI7fJlXoU8g8zAkMtnWWPLoIiXlX/1x4mrijI8bumw+uhShw9gKNtaEXL5QmKSYO
	 z2vTqXatkyjkVaBRlGjiFUUBPnlIJ/tu4o/FyG19gNkKYBG27IJy8XYLHULRevdY5c
	 n3SMSYPqhgjdLQCFoJrnp0vVu2PEn+KNGYWn5j4PKXBFXIrdkN77gqNYv3x3FueMOV
	 MaCGFTjwHi3hQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 58927C4160E; Wed, 13 May 2026 13:28:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 216037] Second MXC6655 accelerometer is not detected on
 transformer Aquarius NS483 laptop
Date: Wed, 13 May 2026 13:28:31 +0000
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
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216037-217253-G54DvL6qjK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216037-217253@https.bugzilla.kernel.org/>
References: <bug-216037-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216037

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INSUFFICIENT_DATA

--- Comment #7 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
Seems no response from the reporter, close as inactive. Feel free to reopen
when new information comes in (see the Q Hans asked, also we need an alive
channel of communication to be able to test and confirm, we have no such HW=
 at
hands).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
