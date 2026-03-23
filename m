Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5DF37105D
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264260; cv=none; b=H76TUYR82wzL9V89SXi2O0yHN7ER1Ja/vOnSSXkSrDF/WhhEF5qdKzeYLenWrzqw0u8z0Nhjbh5hQS0QsGvdmO+EPh84VC8Zbnoo0PABN9Gh0E4lM2yx7+Vu7IAR7PJMtO1pvSg3wtWX+9ycC6KiaEzNzhPAIS7OJHNsIoWuSI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264260; c=relaxed/simple;
	bh=UroZcM9xrzZCtcDwbLXyabbpYElGpT0BlWL9Qk3CWxg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SxtMeQxsJpfIgHpP19hweCCJ+bPjv0RIiV959fY09qBqHwvMLuAZW/vJh7k/RV23SzHrt2Ul2u0kogVvxGhlQlzCI9CCp6W0Gxd4Ve0yNLf0s6jDI/SuFtl8cSnBLE4cc+UH1JviNy7v5ABTiYE+T9XO/ScN+8ICOr4IUUWi3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUqijM8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUqijM8V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B045C2BCB4
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774264260;
	bh=UroZcM9xrzZCtcDwbLXyabbpYElGpT0BlWL9Qk3CWxg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NUqijM8Vjd8+2AkMtRp0+uzo4IeqXe4yGovgnT1VUGGwj5qA3WYGLx7Ydzn+f9xfH
	 8O891rfp8Gsbvv2EsKrQDjbVTh7ZNP8TUANbfwV6mNoDQOuyn6jg3pyCqdyyjYlRgs
	 Q6V8SscJerv9eEvJGY2uOfh8/cmhKsYiAz9TCcDAAAlR/San3S1cqGrGRmWGx7WKVo
	 y3CBw5jrqcaaEYP0JfVzOq3OsvOLVGGX3xqDLzWtR1llSPPIOCrt1uHMoTWwyCJs15
	 BJqrfmdoy7H4fH8bRVwt0NMh1xbAM85ZWPEIqkzUW/nxHPdFdNgE2jJ+PMeskbqRSQ
	 lpmBJULWnK4KQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E31B7C3279F; Mon, 23 Mar 2026 11:10:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 221256] On Boot - WARNING: kernel/irq/manage.c:1502 at
 __setup_irq+0x5bb/0x800, CPU#7: iio-sensor-prox/932
Date: Mon, 23 Mar 2026 11:10:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alain.cousinie@laposte.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221256-217253-KIYxHDoOC4@https.bugzilla.kernel.org/>
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

AlainC (alain.cousinie@laposte.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alain.cousinie@laposte.net

--- Comment #3 from AlainC (alain.cousinie@laposte.net) ---
I'm sorry, but I didn't quite understand what you were saying.

I recompiled with the patch from=20
https://lore.kernel.org/all/20260220224514.471348-1-srinivas.pandruvada@lin=
ux.intel.com/
And the result is positive; there are no more errors.

Alain

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
