Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A992DC77B76
	for <linux-iio@archiver.kernel.org>; Sun, 23 Apr 2023 00:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDWAWh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 22 Apr 2023 20:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWAWg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Apr 2023 20:22:36 -0400
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796BA1FEB;
        Sat, 22 Apr 2023 17:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682209352;
        bh=9luFgRX+xUYAZu6/4d+y7gQdpEOya0tnPMQQsYH7ey4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iDyWCNgehW/GHTnCJoqN9DbYjXwDbeOJffbzMGe9CMUu61oHd5CsEL/+jv8qj6FYS
         gCdw7JcjjjgF4uRppEpfo91yJPvaHhN+ehmnlwKXEDEXGSj0MynPxKLKPxqEmLcg82
         5YiA9x2yVtntwVNfH4MUCgGS6JpktTgPyuwslTVA=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 59D9563A; Sun, 23 Apr 2023 08:22:29 +0800
X-QQ-mid: xmsmtpt1682209349tomu2ejww
Message-ID: <tencent_0359C097ED2A7EAF23A35788000632428008@qq.com>
X-QQ-XMAILINFO: MaZu5Xhaz90xyZLi7eG6DfwuyskB/919VD7/5rJhfG574EAEyZI9/lBRBNAr90
         JBkkVnZRkVBsYZlw+ixhKQMf82M9RaX5FCvDNKGZUX1oBCma+hYg6+FI+YEmBu7QBD/PUkedUa6B
         l+X11MtvqjI47HX/Jbm4njpirYPwz3LtMiRctl5SMz0xwIbXbjkt/DZOFJIYXWEBqenWm51kkhye
         ZV4eDXMFBI/7QabxnY8ahruhHsJKauKG+u8oMX/6NKVmDj39uFNFOkXbDnYWZ4/f6XMDeXNMHTSb
         NFg1SfwANizmf40V3kP7EFphMz3Wcl0qqq3dgQyjtYNFJ1/L4ff4IDegefhE1ouknJpAtdcOTPdw
         s6MDWR1khztB8LJnZr4kpGaXGt3V2OeSRUi8rGh2TSoIcXESldcEAvTAA0ZHr1Ag/t24ZJWQYw89
         CqTLYikWlpasG7FvBa3SLAQehh/yKAGPAE4Yotvq+iNMWtfd4wRo1rFbNq9r6r2O5Edx03Qt82j4
         8M0wK5Vfhzu3MKQK8HiJIlf7mtGMIiJK8TCKrN6WV13TxSBDEUN/4hjPbfLp8B9mTKcLw2VZroB3
         gyYX17XHpC/P1xdRT5r0NTr/qrOGpM0IfYrhyLyGXgGmnk0XPrbchX58ol3EZWOBvQtLklkIRU0w
         Wjy1zCB/re/5xewn0XDSFwZTG+HDJH7fwECxD7wQ2rMTCYu2Q8Aa9dV1kUfnKaN7iaNKG3CDJ4Qj
         DjiZpuibcKZxYwS6NSM8HSEKEiKU9RbjMVHXIT+Zm5oXgUjPBGeqXJaQMZVMrIxG5GUww7v+gXZy
         9TXuDTJKb0HbaKm1gvDNMNFBFrBg9U9T996RCz32oFMeUp1ET0o4YAwgExLNTAwuVslpQqiSHYJL
         p8HB1pNre+5NJcWCD8/90X5uNKlXIhGe52mEmvaxc6qXVPOkV8ndROzIm4wDAkLH4xh51qIgzgzL
         KJFEojv4P2WjUQQsdpDs7Oojf9PICOOSKJ/Vhom6uHwtH+n5v3Hg==
From:   Rong Tao <rtoax@foxmail.com>
To:     william.gray@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        rongtao@cestc.cn, rtoax@foxmail.com
Subject: Re: [PATCH v2] tools/counter: Makefile: Remove lingering 'include' when make clean
Date:   Sun, 23 Apr 2023 08:22:29 +0800
X-OQ-MSGID: <20230423002229.4478-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ZEQGbGor+5i4Gzk/@fedora>
References: <ZEQGbGor+5i4Gzk/@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi, William,

Of course it's okay, thanks.

Rong Tao

