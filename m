Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356811FE45A
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225104; cv=none; b=ppj7GNWOf6yV4P4HrPEGux1Shr2dPdKavMuyL8fMtPJJXUlBO3GnW3qeWo/aZMQiJk6gSZk34B0eYemsF/hc0zQ0eD/+UzPFAz8Ztof4Ct3w/C6iSL77OWIxMonO7Stqhykpg+NFgvf3GEfcB1ehgN2h9xJQWUzIz82sPnrSgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225104; c=relaxed/simple;
	bh=hSE1sXOxu1ObaUUBEf3HcM6Brga2QfIsFW6vemeVT1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TbZVpK/jym0u6CgCM7bdgQ4rnFG9ZlcqsD5xFtifLQY2lsCngcEJ1lv9Ab+eeRULanAuri+wjxf0+V/zepNcu9HOBHiyFcIpZrLHBqrOxcYldrgyGCjBtXdXWl1/C/nJHBGIinVKazo3TOAWNOS2H0nCBSE/1vqQ4LMo7jOalQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2aN6Mzj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2aN6Mzj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1767C116C6
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771225103;
	bh=hSE1sXOxu1ObaUUBEf3HcM6Brga2QfIsFW6vemeVT1A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P2aN6MzjbWJh5xsa0CTWJYfiwrnLjnld57PJqg4coOUB+dhOcG51bSIX8OlGadQzV
	 V7uVo8DDeKjFQDM6mVdsWuBXYVtvYZF71C7aGw6lXavLjckWtNV0uGK0KNsbbvhirK
	 UDaGODBoxGZ+CGy72ipkk+ok46+ZAnFd8mo12M4lREGFBVhYl0evO82vgnze8FaL1D
	 WwZLuW4Hwgp6TfcGSlGnwyHd3I8oJyHF4pwRwXAUfTTp6cvfsJk0cR60ZP/HpO2+q7
	 tY7ofNaXcrjBVlA/vjVANIn8F0sdNGip1z05LWSfnIVct2xx1DGWkrndPrCTwdifgc
	 WkrtQK8ZM+x8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CC1B1C4160E; Mon, 16 Feb 2026 06:58:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221077] [iio] [hid-sensor-rotation] Memory corruption due to
 alignment mismatch in scan buffer
Date: Mon, 16 Feb 2026 06:58:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lixu.zhang@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221077-217253-7ZwcMBlkTK@https.bugzilla.kernel.org/>
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

--- Comment #4 from Lixu Zhang (lixu.zhang@intel.com) ---
> What userspace were you using to test this?

An internal test tool similar to iio_generic_buffer.

Lixu

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
