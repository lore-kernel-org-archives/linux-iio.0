Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53076 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeF3RsG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2018 13:48:06 -0400
Date: Sat, 30 Jun 2018 18:48:02 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [RFC 3/3] iio: imu: bme680: Add ACPI support
Message-ID: <20180630184802.15c97a00@archlinux>
In-Reply-To: <CAEnQRZAayGy9n-h=zirvF6VbVgwDiTM5dr-dJx_b+ys+OitBAg@mail.gmail.com>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
        <1529562877-9357-4-git-send-email-himanshujha199640@gmail.com>
        <20180622144435.0000613b@huawei.com>
        <CAEnQRZCOVrYk=oifne81Fo_ky_3vLq85AwA2v6qJ68s7HRMTDQ@mail.gmail.com>
        <AF0F37DE-70F9-4B88-BEE1-48516E1795BB@jic23.retrosnub.co.uk>
        <CAEnQRZAayGy9n-h=zirvF6VbVgwDiTM5dr-dJx_b+ys+OitBAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 29 Jun 2018 16:02:36 +0300
Daniel Baluta <daniel.baluta@gmail.com> wrote:

> On Mon, Jun 25, 2018 at 1:06 PM, Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
> >
> >
> > On 25 June 2018 08:40:08 BST, Daniel Baluta <daniel.baluta@gmail.com> wrote:  
> >>On Fri, Jun 22, 2018 at 4:44 PM, Jonathan Cameron
> >><jonathan.cameron@huawei.com> wrote:  
> >>> On Thu, 21 Jun 2018 12:04:37 +0530
> >>> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> >>>  
> >>>> Add support to probe the bme680 sensor on the i2c bus using
> >>>> ACPI.
> >>>>
> >>>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> >>>> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>  
> >>>
> >>> This looks fine.  Do we know for sure that they use that ACPI
> >>> ID?  For these sorts of devices, it's fairly common to have entirely
> >>> random ids presented.   Also, I'm a little curious to know, what
> >>> ACPI based device has one of these?  
> >>
> >>Hi Jonathan,
> >>
> >>I am not aware of any ACPI device using our chosen ID. We just
> >>picked BME0680 based on previous drivers from Bosch.
> >>
> >>It is useful to enumerate the sensor via ACPI because our
> >>qemu testing setup uses ACPI.  
> >
> > Cool. Any docs on that setup?  Would be useful blog post if easy to do.  
> 
> We have multiple iterations of our setup, depending on the project.
> 
> Generic description that we use at University can be found here:
> 
> https://linux-kernel-labs.github.io/master/labs/vm.html
> 
> Scripts are here:
> 
> https://github.com/linux-kernel-labs/linux/tree/master/tools/labs/qemu
> 
> For IIO we use DLN2 (USB-I2C/SPI) adapter and we pass
> -acpitable file=description.aml to qemu.
> 
Cool. I just got around to getting one of these last week as
it seemed a useful tool to have!

Thanks - will have a play with this when I get some time.

Jonathan
> 
> thanks,
> Daniel.

