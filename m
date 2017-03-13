Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48056 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753554AbdCMUoB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:44:01 -0400
Subject: Re: [PATCH] iio: sw-device: Fix config group initialization
To: Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <1489076404-11490-1-git-send-email-lars@metafoo.de>
 <CAEnQRZBrMqRpb_u1MOLQm7xue=qjWRen8nZ_px7AZfW1Xgs7TQ@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Miguel Robles <miguel.robles@farole.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fb02f85c-7ef0-18fd-1eb0-1d2385b355c1@kernel.org>
Date: Mon, 13 Mar 2017 20:43:58 +0000
MIME-Version: 1.0
In-Reply-To: <CAEnQRZBrMqRpb_u1MOLQm7xue=qjWRen8nZ_px7AZfW1Xgs7TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/17 07:54, Daniel Baluta wrote:
> On Thu, Mar 9, 2017 at 6:20 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> Use the IS_ENABLED() helper macro to ensure that the configfs group is
>> initialized either when configfs is built-in or when configfs is built as a
>> module. Otherwise software device creation will result in undefined
>> behaviour when configfs is built as a mdoule since the configfs group for
>> the device not properly initialized.
>>
>> Similar to commit b2f0c09664b7 ("iio: sw-trigger: Fix config group
>> initialization").
>>
>> Fixes: 0f3a8c3f34f7 ("iio: Add support for creating IIO devices via configfs")
>> Reported-by: Miguel Robles <miguel.robles@farole.net>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
Applied to the fixes-togreg branch of iio.git
with description typo fixed and marked for stable.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

