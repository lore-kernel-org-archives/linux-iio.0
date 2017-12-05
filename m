Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:43252 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdLESFa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Dec 2017 13:05:30 -0500
Received: by mail-it0-f68.google.com with SMTP id u62so3694707ita.2
        for <linux-iio@vger.kernel.org>; Tue, 05 Dec 2017 10:05:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d260e712-ec2f-33d5-e368-86c2e7ffa19e@metafoo.de>
References: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
 <20171202115257.5e561988@archlinux> <d260e712-ec2f-33d5-e368-86c2e7ffa19e@metafoo.de>
From: Matthew Fornero <matthew.fornero@gmail.com>
Date: Tue, 5 Dec 2017 10:05:28 -0800
Message-ID: <CABdUomwoEJdgqsrHz6jXr1P6JwL=faPKeq8ogHA9k8LB5bncvA@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer-dma: Expose data available
Cc: linux-iio@vger.kernel.org,
        Matt Fornero <matt.fornero@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Dec 5, 2017 at 1:32 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> I guess one question is whether this should be generic.
> iio_dma_buffer_data_available() is a generic function and not specific to
> the DMA buffers, so it would work just fine for FIFO based buffers as well.

So it looks like we could implement this generically as a member of
iio_buffer_attrs, and have it simply use iio_buffer_data_available()
instead of iio_dma_buffer_data_available().

This would also be a bit cleaner, as the iio_buffer_attrs logic already
has code to append existings attrs, allowing device-specific attrs to be
easily added.

What about the case when the data_available element in
iio_buffer_access_funcs is undefined (e.g. industrialio-buffer-cb)?
Do we modify iio_buffer_data_available() to return 0, do we make the
sysfs function return -ENOENT or -EINVAL (or simply not expose the sysfs
interface for this case)?
