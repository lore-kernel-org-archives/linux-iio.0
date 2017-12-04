Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from a8-57.smtp-out.amazonses.com ([54.240.8.57]:47090 "EHLO
        a8-57.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750854AbdLDS6O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Dec 2017 13:58:14 -0500
Date: Mon, 4 Dec 2017 18:58:13 +0000
From: Jeremy Cline <jeremy@jcline.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
Message-ID: <0100016022e49231-8c4ef123-bd0d-49b4-a217-0d81100ce322-000000@email.amazonses.com>
References: <20171129223016.17848-1-jeremy@jcline.org>
 <0100016009e7c30a-407c2980-d8d5-4506-ab47-d0fb2fed481d-000000@email.amazonses.com>
 <20171202121927.3b7aa028@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171202121927.3b7aa028@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Dec 02, 2017 at 12:19:27PM +0000, Jonathan Cameron wrote:
> > diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> > index c38754452883..7f49a09b136f 100644
> > --- a/drivers/iio/accel/bmc150-accel.h
> > +++ b/drivers/iio/accel/bmc150-accel.h
> > @@ -47,6 +47,7 @@ struct bmc150_accel_data {
> >  	int ev_enable_state;
> >  	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
> >  	const struct bmc150_accel_chip_info *chip_info;
> > +	void *driver_priv;
> 
> I'd be explicit about what this is rather than just calling it driver_priv.

Ah, okay. I was worried about putting i2c-specific stuff in there.

> Also patch 1 was entirely to expose this data element.  Adding simple
> bmc150_get_second_device() / bcm150_set_second_device call would avoid that.

That hadn't occurred to me. I'll take a look at doing it that way.

Thanks for the feedback!

Regards,
Jeremy
