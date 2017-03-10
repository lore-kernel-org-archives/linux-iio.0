Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36269 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755128AbdCJHyy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2017 02:54:54 -0500
Received: by mail-io0-f195.google.com with SMTP id 68so6284431ioh.3
        for <linux-iio@vger.kernel.org>; Thu, 09 Mar 2017 23:54:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1489076404-11490-1-git-send-email-lars@metafoo.de>
References: <1489076404-11490-1-git-send-email-lars@metafoo.de>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 10 Mar 2017 09:54:52 +0200
Message-ID: <CAEnQRZBrMqRpb_u1MOLQm7xue=qjWRen8nZ_px7AZfW1Xgs7TQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sw-device: Fix config group initialization
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Miguel Robles <miguel.robles@farole.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 9, 2017 at 6:20 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Use the IS_ENABLED() helper macro to ensure that the configfs group is
> initialized either when configfs is built-in or when configfs is built as a
> module. Otherwise software device creation will result in undefined
> behaviour when configfs is built as a mdoule since the configfs group for
> the device not properly initialized.
>
> Similar to commit b2f0c09664b7 ("iio: sw-trigger: Fix config group
> initialization").
>
> Fixes: 0f3a8c3f34f7 ("iio: Add support for creating IIO devices via configfs")
> Reported-by: Miguel Robles <miguel.robles@farole.net>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
