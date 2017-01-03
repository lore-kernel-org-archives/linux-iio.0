Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:45200 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755930AbdACIEV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Jan 2017 03:04:21 -0500
Date: Tue, 3 Jan 2017 09:04:19 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: "Song, Hongyan" <hongyan.song@intel.com>
cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH 1/2] iio: Add support for linear accel
In-Reply-To: <AE3E3DFA698D6144A7445C92D1D41E2F10BDBD57@SHSMSX103.ccr.corp.intel.com>
Message-ID: <alpine.DEB.2.02.1701030851430.18919@pmeerw.net>
References: <1483456430-6980-1-git-send-email-hongyan.song@intel.com> <alpine.DEB.2.02.1701030821450.18919@pmeerw.net> <AE3E3DFA698D6144A7445C92D1D41E2F10BDBD57@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> 	 I checked and find that iio device name is usually named to be with underline if it has more than one word, so I assigned to be " linear_accel_3d".
>  I think the device property node named to be "in_linear_accel_x_raw" is better than " in_linearaccel_x_raw" Just follow the former coding style.
> "linearaccel" is only a name which specify IIO type [IIO_LINEAR_ACCEL]
> I name [IIO_LINEAR_ACCEL] to be "linearaccel" just follow the history code style in " iio_chan_type_name_spec[]" which do not have any underline.

> > +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_x_raw
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_y_raw
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_z_raw
> 
> I think this would be in_linearaccel_x_raw, etc.?

> > @@ -82,6 +82,7 @@ struct bus_type iio_bus_type = {
> >  	[IIO_UVINDEX] = "uvindex",
> >  	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
> >  	[IIO_GRAVITY]  = "gravity",
> > +	[IIO_LINEAR_ACCEL] = "linearaccel",
> >  };


linearaccel vs. linear_accel is a matter of taste, I have no preference;
nevertheless, the documentation should match what IIO outputs

if you have "linearaccel" in iio_bus_type, I think the name of a 
LINEAR_ACCEL channel will end up as "in_linearaccel_x_raw" and must be 
documented like that -- i.e. there is a mismatch between 
documentation and actual code/output

probably your patches should be rebased, iio/testing branch has IIO_COUNT 
and IIO_INDEX channels

regards, p.


-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
