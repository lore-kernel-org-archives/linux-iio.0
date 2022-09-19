Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4032FECAAA1
	for <linux-iio@archiver.kernel.org>; Mon, 19 Sep 2022 19:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiISTVN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiISTVM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 15:21:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456303ECDD
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 12:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 008C3B81F0C
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 19:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8B86C433D7
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663615269;
        bh=q/wcam+aynjO0fgk0ZgtkOLIJPb4M9i0+NZJzr1z8nk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i3bCUOJlU961dq2iQFrmQbPu2Ng7t0aAPNHIXpIo1Stbw9TiIqDPDm/ZzMjTFHUsE
         51W4BgznRmdZ/WF0J5Ba6GsGVcdF32dx8cFALGMRNqnaweakz1S1oq4rL7t77YeC8E
         HAO2z2CbYg8u2rQYIKLSOZS9YwHV1yBYtfbplteiyxiTz6bWlmIk6eY9BsRxhU+RBq
         yjZtKXfyGhAuaXmmazcJ+SbASsEQtqaBZyG4u5OcCJW27TZKp2A7ShSaAk4Q3b0lB+
         jqMfy56eRVL+PKUyrO2U7f5KwmEQWveMB5CDqK4HWPfA2TGdY2U+8ckAcJrJ4uZHP4
         3x5EAmDiqS7ZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 916A5C433E4; Mon, 19 Sep 2022 19:21:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 200775] Cannot read the accelerometer raw data from the sensor
 LNG2DM
Date:   Mon, 19 Sep 2022 19:21:09 +0000
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
Message-ID: <bug-200775-217253-tQYUWlmHkE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200775-217253@https.bugzilla.kernel.org/>
References: <bug-200775-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D200775

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INSUFFICIENT_DATA

--- Comment #9 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
Closed based on comment #8. Feel free to reopen if any new information is
available.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
