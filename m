Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCAF18C2C
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225424; cv=none; b=ncg2ZQDAK9IfesNIzYTqqt14KwYcg9piP6ZQJR2mnAjALS1t8GevEY8nodKtvXUcLi/zY2pNDNOe3hvsSfEMjiaa2T/60oUcpdfvxcJQaQXMXyw2DcKdTwfAfSgAYCIX1nNR7qO46oDw18xWbhrdpQ6xCRXFRFVdrm4iziqqplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225424; c=relaxed/simple;
	bh=9NVBaXXgFwAKP9+TOIKQsHJ/JbEzC5lRuZLEk7c5/LM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6P1ZfuJu6ohkldLynqt/CVLqLkH7ZXcJvuYqrvDKzVLr9ij++CX9PvMXDBUxDsi7vKSKzlrOsOy83dUFmeAy9BEQgmizw5VxT/DSs1vUXONqAaxWwCiAz+2I8fn5jVR0wHVFpQZhIaJv3ILFvh5WkagsJ/opm3XKOIu8yoWqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWk498EI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWk498EI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAEEFC19425
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 07:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771225423;
	bh=9NVBaXXgFwAKP9+TOIKQsHJ/JbEzC5lRuZLEk7c5/LM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HWk498EIdGgKrZb5WBefRSSeGjbD4iK0oW30N4TUqMkWGsJ4tvnEIKSDSKHypX7PH
	 RJ/TbxXwyJ06PrLcL0BI/bLSAaPaeDi3CWHjYemPrEg8LIxRz8J6F0Ku0ZPHlNQMRC
	 oKtmWc9L6pjdaSeFt3LTLvh2Y/7p+3KixPTtAPl6eeyfCbUQHMHA0ezfZmwTFJc5Cr
	 Y1Et1AZp6nahC/jKJH+7/oCkZbOJbt5y3P6M7teX5bpcph/oGI1C6DlngdVCmTxs9G
	 x4bW3IBcE56SK9MTqH1JxDczjMmCR0fxbFvaZ51eqBeL4K1ZkHZGsi25G4mPFqAPVD
	 uYGufSu1+k++g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9E02CC4160E; Mon, 16 Feb 2026 07:03:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221077] [iio] [hid-sensor-rotation] Memory corruption due to
 alignment mismatch in scan buffer
Date: Mon, 16 Feb 2026 07:03:43 +0000
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
Message-ID: <bug-221077-217253-nZhcrXDtrY@https.bugzilla.kernel.org/>
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

--- Comment #5 from Lixu Zhang (lixu.zhang@intel.com) ---
Hi David,=20=20

Thank you for the patch! I'm currently on Chinese New Year holiday and
attempted to remotely access my test machine to verify the fix, but
unfortunately couldn't establish a connection.

I will test the patch as soon as I'm back in the office and provide feedbac=
k.

Best regards,
Lixu

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
