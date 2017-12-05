Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:39359 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbdLESL3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Dec 2017 13:11:29 -0500
Received: by mail-it0-f46.google.com with SMTP id 68so3648868ite.4
        for <linux-iio@vger.kernel.org>; Tue, 05 Dec 2017 10:11:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a4dd5967-e905-70c0-e84b-ea64f45dc134@metafoo.de>
References: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
 <20171202115257.5e561988@archlinux> <d260e712-ec2f-33d5-e368-86c2e7ffa19e@metafoo.de>
 <CABdUomw1Z=CTq5m5jBic-=PNtn3DGU1L3b3O6bhzX-MOo2iCrw@mail.gmail.com> <a4dd5967-e905-70c0-e84b-ea64f45dc134@metafoo.de>
From: Matthew Fornero <matthew.fornero@gmail.com>
Date: Tue, 5 Dec 2017 10:11:28 -0800
Message-ID: <CABdUomwzhiEkOECPGG5T08eqydGuHmsCSfkH0wCbPm6wOzeXig@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer-dma: Expose data available
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Matthew Fornero <matthew.fornero@gmail.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        linux-iio@vger.kernel.org,
        Matt Fornero <matt.fornero@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Dec 5, 2017 at 10:08 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> > What about the case when the data_available element in
> > iio_buffer_access_funcs is undefined (e.g. industrialio-buffer-cb)?
> > Do we modify iio_buffer_data_available() to return 0, do we make the
> > sysfs function return -ENOENT or -EINVAL, or simply not expose the sysfs
> > interface for this case?
>
> The callback buffer does not support any of the interfaces required for the
> userspace facing side. E.g. there is no read() callback.
>
> For proper support of the userspace interfaces data_available() is required,
> otherwise read() would never return. So I think this is fine, we'd never
> register the userspacing interface if it didn't have the data_available
> callback.

So there should already be provisions in place for *not* registering the
cb buffer with user-space, meaning no additional logic would be required
for exposing / not exposing a "data_available" sysfs attribute, correct?

Assuming the above is correct, I'll come back with a generic v2 of this.
