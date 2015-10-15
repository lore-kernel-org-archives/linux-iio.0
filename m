Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37934 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbJOIzP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Oct 2015 04:55:15 -0400
Received: by wicll6 with SMTP id ll6so8486037wic.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2015 01:55:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAF8px55G9aLXWcRKvhfAb7W=GUSbGn9TKdr_wnPyYiiTg-qG6w@mail.gmail.com>
References: <CAF8px55G9aLXWcRKvhfAb7W=GUSbGn9TKdr_wnPyYiiTg-qG6w@mail.gmail.com>
Date: Thu, 15 Oct 2015 11:55:14 +0300
Message-ID: <CAEnQRZCHh96gHnTVPpLi=my4DeqzFQAyXo3whYONXsVKyKrqBg@mail.gmail.com>
Subject: Re: iio: inv_mpu6050: client: Erratic data.
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Mike Mestnik <cheako@mikemestnik.net>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 14, 2015 at 11:13 PM, Mike Mestnik <cheako@mikemestnik.net> wrote:
> This was taken with the tablet as still as I could without resorting
> to using a vice and clamps.
>
> How to know if this is kernel or app?

Looking at the message format it seems to be an user space app log.

You can also send us the 'dmesg' command output.

thanks,
Daniel.
