Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35839 "EHLO
	mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158AbcGJNLm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 09:11:42 -0400
MIME-Version: 1.0
In-Reply-To: <CAHNg1SoX_VFcKLYTmir9=Mh-UtLjGqJ_Q3xbfyxKv+HAAQGFCg@mail.gmail.com>
References: <CAHNg1SoX_VFcKLYTmir9=Mh-UtLjGqJ_Q3xbfyxKv+HAAQGFCg@mail.gmail.com>
From: Pratik Prajapati <pratik.prajapati12@gmail.com>
Date: Sun, 10 Jul 2016 18:41:40 +0530
Message-ID: <CAHNg1Sqe4FRKSzxPsXni6xYCBLQovAYvGoeNQpzi531J6V+K0A@mail.gmail.com>
Subject: Re: How to set Current register in IIO driver from sysfs
To: linux-iio@vger.kernel.org, jic23@kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Including more members.

On Sat, Jul 9, 2016 at 5:22 PM, Pratik Prajapati
<pratik.prajapati12@gmail.com> wrote:
> Hi,
>
> I am trying to add support of adjusting IR led current in vcnl4000
> driver (has IR led current register for doing the same).
>
> Below is what I have done till now:
>
> 1) Added Current channel in the vcnl4000_channels structure with
> separate mask IIO_CHAN_INFO_RAW
> 2) Reading the LED current register inside IIO_CURRENT case in vcnl4010_read_raw
> 3) Writing to LED current register inside IIO_CURRENT case in vcnl4010_write_raw
>
> Is this the correct way of setting Current register in IIO subsystem?
>
> Best Regards,
> Pratik Prajapati
