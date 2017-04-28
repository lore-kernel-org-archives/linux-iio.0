Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32931 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932404AbdD1XDU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Apr 2017 19:03:20 -0400
Received: by mail-qt0-f195.google.com with SMTP id c45so10306128qtb.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Apr 2017 16:03:20 -0700 (PDT)
From: Quentin Swain <dudebrobro179@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuls.org
Subject: Fix permissions warning from check-patch for tsl2x7x
Date: Fri, 28 Apr 2017 19:03:06 -0400
Message-Id: <20170428230307.23491-1-dudebrobro179@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Fix up complaints from check-patch regarding preference for octal permissions over symbolic permissions
