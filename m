Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:46047 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab3K0EkY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Nov 2013 23:40:24 -0500
Received: by mail-ob0-f172.google.com with SMTP id gq1so6886678obb.3
        for <linux-iio@vger.kernel.org>; Tue, 26 Nov 2013 20:40:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5290F73D.1000306@kernel.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
	<5290F73D.1000306@kernel.org>
Date: Wed, 27 Nov 2013 10:10:23 +0530
Message-ID: <CAK9yfHz8=fprTq8Y=03+uC=S9MBhPL4bzJUTOsvJ1zrHhusneA@mail.gmail.com>
Subject: Re: [PATCH Resend 00/33] iio: Implement and use devm_iio_device_register
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 24 November 2013 00:13, Jonathan Cameron <jic23@kernel.org> wrote:
> On 10/29/13 11:39, Sachin Kamat wrote:
>> Resending this series after rebasing onto the latest iio tree.
>> Previous version is available at [1].
>> [1] http://www.spinics.net/lists/linux-iio/msg10682.html
>>
>> * Added tested and reviewed by tags to patch 1. Thank you Lars.
>> * Included a patch (patch2) to re-organise the kernel doc
>>   as suggested by Lars.
>
> Hi Sachin,
>
> Having finaly waded through this whole set I have a few general comments.
> Firstly, I am sorry I am refusing to take so many of these.  I did mention
> in response to an earlier series that I was not keen on applying this
> shortening in code, if there was stuff that should be done after the
> unregister, but which was not.
>
> I have kept to that as I would much rather see those drivers improved by
> adding for example power down of the part on removal of the driver or making
> sure that the removal is in the correct order.  Feel free to try and
> talk me around though!

Thank you for patiently reviewing all the patches and providing your comments.
I agree with your concerns and your decision to have the missing
things implemented
in the drivers first before optimizing them.

> Anyhow, thanks for your hard work on this.

Thanks for your support.

-- 
With warm regards,
Sachin
