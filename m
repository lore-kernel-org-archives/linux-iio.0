Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195802343BE
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900869; cv=none; b=C/kkRHWf2gjfVgpjzx2tLo6DFURt/K5OuPYUPIdXx48P/agpH3rzFz82as3sBDMhC4Wfvjl90X5FVOhMXC7BhqcEUx4AA0EbMhtk+eKV+zO/efSSr6iyD1i1yQxZO84WsG/YnNQ6Q0svQ21+u7cZHrZjquFb/+a5lZrfouWVmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900869; c=relaxed/simple;
	bh=Arm+LlXjTVRe1a8QG7CWJSUw8D5wvuk9VjrGLqohcvw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MV/We0IBRM7N5+xjEtW+ISCd8cnHA3rGGlA8+41AYzqYkpD15cumj4zrJ4ATja1L0CXx5XKUDihHMRCjKV6Mw7w7zHW2jZG8sUvT+EJ+7FxxXvDPvBFsFz8N9ZxQHlb6k4IP/0gb+FjGn51fSGGaC+ctPvbCWUgH4GMBI4+LbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8nhPCf3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8nhPCf3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1F88C19424
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 02:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771900868;
	bh=Arm+LlXjTVRe1a8QG7CWJSUw8D5wvuk9VjrGLqohcvw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R8nhPCf3tE2k455JANqKJ8Szsubn6HyFs1OFZFajKSSQ8blVu1jrpW9r9Xvmf6Rq/
	 kIepUHi8lXgpXOGhdfAtOe43XiOiIlSymOv0N/aevhV9nf0QEPBuejyY50yzwmbc50
	 SlX5bsxcozYxiDKhVNcW2CN20cH6AY39kJfslKazqt0thchEccpxDG3KpHAgX43N+e
	 hjQ6+azth1iuNLGIIu7gLCq7Y4JrKlWJPbW+df586rOsXqfqwyTfn1FFTrD8Fnyb5j
	 y49XiNpyH08WeOaOdOXDe0inKpix5Zey6+2ivO6YGQMlw5jKPaHtz5758B9gaC0ZoR
	 6y/h3kMh9MpNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ABA4DC41613; Tue, 24 Feb 2026 02:41:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221077] [iio] [hid-sensor-rotation] Memory corruption due to
 alignment mismatch in scan buffer
Date: Tue, 24 Feb 2026 02:41:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lixu.zhang@intel.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221077-217253-2GdjE90W4k@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221077-217253@https.bugzilla.kernel.org/>
References: <bug-221077-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221077

Lixu Zhang (lixu.zhang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #6 from Lixu Zhang (lixu.zhang@intel.com) ---
With `[PATCH 0/2] iio: orientation: hid-sensor-rotation: fix quaternion
alignment`, the bug is fixed. Thanks.

Lixu

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
