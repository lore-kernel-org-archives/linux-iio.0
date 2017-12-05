Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:59653 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbdLESIM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Dec 2017 13:08:12 -0500
Subject: Re: [PATCH] iio: buffer-dma: Expose data available
To: Matthew Fornero <matthew.fornero@gmail.com>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        linux-iio@vger.kernel.org,
        Matt Fornero <matt.fornero@mathworks.com>
References: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
 <20171202115257.5e561988@archlinux>
 <d260e712-ec2f-33d5-e368-86c2e7ffa19e@metafoo.de>
 <CABdUomw1Z=CTq5m5jBic-=PNtn3DGU1L3b3O6bhzX-MOo2iCrw@mail.gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <a4dd5967-e905-70c0-e84b-ea64f45dc134@metafoo.de>
Date: Tue, 5 Dec 2017 19:08:07 +0100
MIME-Version: 1.0
In-Reply-To: <CABdUomw1Z=CTq5m5jBic-=PNtn3DGU1L3b3O6bhzX-MOo2iCrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/05/2017 07:01 PM, Matthew Fornero wrote:
> On Tue, Dec 5, 2017 at 1:32 AM Lars-Peter Clausen <lars@metafoo.de
> <mailto:lars@metafoo.de>> wrote:
>> I guess one question is whether this should be generic.
>> iio_dma_buffer_data_available() is a generic function and not specific to the
>> DMA buffers, so it would work just fine for FIFO based buffers as well.
> 
> So it looks like we could implement this generically as a member of
> iio_buffer_attrs, and have it simply use iio_buffer_data_available()
> instead of iio_dma_buffer_data_available().
> 
> This would also be a bit cleaner, as the iio_buffer_attrs logic already
> has code to append existings attrs, allowing device-specific attrs to be
> easily added.
> 
> What about the case when the data_available element in 
> iio_buffer_access_funcs is undefined (e.g. industrialio-buffer-cb)? 
> Do we modify iio_buffer_data_available() to return 0, do we make the
> sysfs function return -ENOENT or -EINVAL, or simply not expose the sysfs
> interface for this case?

The callback buffer does not support any of the interfaces required for the
userspace facing side. E.g. there is no read() callback.

For proper support of the userspace interfaces data_available() is required,
otherwise read() would never return. So I think this is fine, we'd never
register the userspacing interface if it didn't have the data_available
callback.
