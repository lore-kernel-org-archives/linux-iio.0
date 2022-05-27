Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E614C433F5
	for <linux-iio@archiver.kernel.org>; Fri, 27 May 2022 16:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348589AbiE0QMH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 27 May 2022 12:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347521AbiE0QMG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 May 2022 12:12:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5373D48E58
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 09:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFD7CB80C9C
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 16:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A887C385B8
        for <linux-iio@vger.kernel.org>; Fri, 27 May 2022 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653667922;
        bh=T/4j/nHRjvVqK4fJ3rEavy2JdznUNrD2zefvq1qA4x8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Tc6lGw8XLmjLa3lP9NUNA/M6WpT+3tetO6Z/t5nlmSQ5kN5gNnwoVDf9M5t551Pfm
         QE19uQl3wm6jaRLrQiZY2XOynVryF1bcusbSSrGhsrm2ncNWwb0CDflDnj6r4iee7m
         MQy/P3XTRi3ec29rGAEPCcfD3CeWOreR4tLKP37k9WPMNOBvO5pmywm1n0YsWBBxPI
         gDCFjPp+egGoISMzbtMLnK+dlpg4wQAPcD3bQ3KL58p6b2lrLETlpjXNkAl151LT4A
         BinXJP7n/LxDKGRd4l11PjLXp4co4E6BK8u59Kx0ZW7KN+gPYVjPiB7ZyjuCnIoLbS
         mMaTVdlbpwpMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 56076C05FD5; Fri, 27 May 2022 16:12:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 216037] Second MXC6655 accelerometer is not detected on
 transformer Aquarius NS483 laptop
Date:   Fri, 27 May 2022 16:12:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nickel@altlinux.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216037-217253-MWShfOqnmW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216037-217253@https.bugzilla.kernel.org/>
References: <bug-216037-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216037

--- Comment #4 from Nikolai (nickel@altlinux.org) ---
Created attachment 301061
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301061&action=3Dedit
gdbus introspect

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
