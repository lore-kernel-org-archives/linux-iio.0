Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049E2746B
	for <linux-iio@vger.kernel.org>; Thu, 12 Dec 2024 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733968121; cv=none; b=jM+K8irchjIiqmuljP00HX5o/z3d83TkCDZQlwTNYJayTnFp1zzLxEnQKPKTl3hxx16ZJRAOzre2Z9w/iiLacmNHcMG/adE//5DSZLNCbvPWaIPAjJ8/O5MBkl5XK1fsm5m7G4ywXgCsQURe21VrIlp8i4uhzdjTXRhClcI9lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733968121; c=relaxed/simple;
	bh=poJPOoDjfos1B88ZtEGXF+wU9bGGsNNhFNAkH5J1gtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OmZA07lx+dMdADv5DkrZg1NG31mGxNp7NLWB/GndNLPrqVyRvj8f2BVALxPYELPirow8w0y6GHP/7TSjNaspUssCmKrd5miRn5VydlQtfUZ+O6dIerUUo4yVcE3YIw90ecKnRN2UMA9eHDtM4zCQ9+Exaus0VgLl1SU+epr1FUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVKLz2xr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVKLz2xr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10C47C4CED2
	for <linux-iio@vger.kernel.org>; Thu, 12 Dec 2024 01:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733968121;
	bh=poJPOoDjfos1B88ZtEGXF+wU9bGGsNNhFNAkH5J1gtY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dVKLz2xrA+/A+LvlG+s8fzSJckhdG+UAJt1TxxnrX6dnDDJAJsD9+1wjDYbyrWS5h
	 mQGTfRqom9V8Wj+/ZY/PDzT2JPvbII9esTOVOW7tD1dCUXeqYM+Z1E/hgrn1drtFiD
	 7xMdDwSj9htMXUNHyE1OnztJ1dOd4tc3UrOfpfxCrgV4mVYPOv4YoIGfG8VfbQG44d
	 Kjy0Fw5mmR4DnOQ0EvNGAVC0CbsFY0gxCOOL+nF9EoGW6+hwRlS/Kxj8RYatvhINTj
	 GExdFbJAp1QHOS+Dy8H27Qs125pS6kTXm+lWd2aCrk340kc1zTWU9E/CCq3deIaC7V
	 OFRi38z8cyXFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ED421C3279E; Thu, 12 Dec 2024 01:48:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219418] BOSC0200 Accelerometer Invalid chip 12 initialization
 error
Date: Thu, 12 Dec 2024 01:48:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cameraphone77@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219418-217253-SaeQH6Lny0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219418-217253@https.bugzilla.kernel.org/>
References: <bug-219418-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219418

Camera Phone (cameraphone77@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INSUFFICIENT_DATA

--- Comment #7 from Camera Phone (cameraphone77@gmail.com) ---
I'm going to mark this as resolved as we Bosch will not provide the datashe=
et
for this chip.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
