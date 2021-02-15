Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68174C433E0
	for <linux-iio@archiver.kernel.org>; Mon, 15 Feb 2021 11:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C0B64D9D
	for <linux-iio@archiver.kernel.org>; Mon, 15 Feb 2021 11:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBOLLu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 15 Feb 2021 06:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhBOLLs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 06:11:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D505464E64
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 11:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613387467;
        bh=GuzEclWYR5fr5SIp3ze50oicrsA7KHD7T7kGkLgmV4g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uGxLk/eytTyrck4uU96WK2OcWrg21cqqQciMC1paHgfCqI0yzVKELB4YhRh4/f9rf
         qAUJKXueHFkZ1+LzQf191vMzpfl3OKhAoKjrkOyoJxD2dLtufZpwq31vIhGNtSoQvq
         OQE15LeyEyfLab4GPx7NTpDwdi1BBrwN4+GOf7Czu1ehxd6D4d7NMOQ5JfO0BzBnPz
         jVrEhmxUKRkPZt1SuufDkBIVBA5wEJ6kUXZls5UObOP/86Z2cRLkOdRI8Sj9TwuPkW
         x0ug5PRA+LmYHscu9vJFDkZKctLz1qKnAVOjOXoV2YTJzBsCJxsOnxVdYjVDP9Ek8y
         HcnuWjr995f0g==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 80511] iio/frequency/ad9832.c:125: pointless test ?
Date:   Mon, 15 Feb 2021 11:11:07 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component assigned_to
Message-ID: <bug-80511-217253-29w0goJ8js@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80511-217253@https.bugzilla.kernel.org/>
References: <bug-80511-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D80511

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |andy.shevchenko@gmail.com
          Component|Staging                     |IIO
           Assignee|drivers_staging@kernel-bugs |drivers_iio@kernel-bugs.ker
                   |.osdl.org                   |nel.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
