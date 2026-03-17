Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0637D136
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770729; cv=none; b=mWMnZ8/049Wl7dE+2r4rkuktyovL4bYcN6CGhNt0/PcKswiBOX6wLuLX4UNx0pVtrP5CY5U458lEKsOxT1ebOyZl4t68xxcHhaztFx7hDe26hEghBPGYfB2w2+YeX/NZGz05Jhm4VMwaBFTbW7z3Q7U7lZplpiJ5T1RMsrtonWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770729; c=relaxed/simple;
	bh=C6GinonwpM/chjGWIO5kpelT+2Cdrwt3kRGSqjvV+R8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U27OGljGmvRoUzIwRKT3Ui0Q01XuoO1FBgCfSeAbeRza8AirPAPdCwhMjro7a2RbWE61MaI+AsrFdl9L8VjamR35JvBX8ZDtfMOWVGnInZEX8ugwLEZcSQQU4qr/D7RIT99uAp4eTAIBLgFi7BkOpZutYJyj/LWYn1BKSGswHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXHnNu3L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXHnNu3L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADCE7C2BC86
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 18:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770728;
	bh=C6GinonwpM/chjGWIO5kpelT+2Cdrwt3kRGSqjvV+R8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qXHnNu3L4HSztHCPlOTg+a+43JlSUW3alV/u1+JUjlTZXA9VkMHxbONks2BapCpKV
	 xgGvSmLynujc1GBks/zgovu9fPKMMsDdACccYI0K13wILvm08oJGgOxgbwcx+emTV6
	 KXDCAXvEMaa/2P9WhmUCsyhm/mmJTA1YiPQbQrFK+RGrqq4EOAjbjQEbe5aoCoD833
	 AP3EYc69yX/cqootMGwqdM7kHU7l44fdWbiex+a3NTGrDUBfiDrMXAWzSJ1p8NHYyn
	 xzQZjHF4+xjIa/ecxo654t142yTkpnzNgjb5LYwq0F9M75JV5eig0WDs7+jvvhsggP
	 /cPfS5Jzlo/2A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A7235C41614; Tue, 17 Mar 2026 18:05:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220772] NULL pointer dereference in bmc150-accel-core
Date: Tue, 17 Mar 2026 18:05:28 +0000
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
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution
Message-ID: <bug-220772-217253-p7Yk8QXqRm@https.bugzilla.kernel.org/>
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
         Resolution|CODE_FIX                    |PATCH_ALREADY_AVAILABLE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
