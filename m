Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39500 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753171Ab3JUL7Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2013 07:59:25 -0400
Date: Mon, 21 Oct 2013 12:59:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lukasz Czerwinski <l.czerwinski@samsung.com>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"denis.ciocca@st.com" <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC v2 PATCH 01/14] iio: st_common: New interrupt interface
Message-ID: <20131021115915.GG8144@kartoffel>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
 <1380299538-22047-2-git-send-email-l.czerwinski@samsung.com>
 <524AEB97.1090806@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <524AEB97.1090806@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Oct 01, 2013 at 04:34:47PM +0100, Jonathan Cameron wrote:
> On 09/27/13 17:32, Lukasz Czerwinski wrote:
> > This patch adds two interrupts handling by the st_common library.
> > Additional second interrupt is used to indetify enabled event support for
> > chosen ST device. It supports board files and dt.
> >
> > For dt interface multiple interrupts are passed through interrupt-names
> > property.
> >
> > Read drdy_int_pin value is moved to the st_sensors_parse_platform_data()
> > in the st_sensors_i2c.c and st_sensors_spi.c Now drdy_int_pin can be
> > also configured via dt.
> >
> > Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> The code here is absolutely fine, though I would like some comments
> on this from Denis and/or Lee (as they are much more familiar with the driver
> than I am!
> 
> The one element that is problematic is the use of interrupt names in specifying
> the two interrupts.  Unforunately, for reasons that I think can be sumarized
> as historical precedence and avoiding complexity of passing in other OSes,
> the device tree powers that be are very anti doing multiple optional interrupts
> this way and consider interrupt-names to be merely for information rather than
> to be used to allow 'optional' interrupts.

There is some disagreement on this point. I think that using interrupt-names to
describe the set of interrupts you have makes a great deal of sense given how
common it is for only an arbitrary subset of interupts to be wired up.

There is an obvious problem in adding *-names properties to existing bindings
in that an existing OS will not know of the *-names property and may parse a DT
in a way that's not in accordance with the intended meaning. Depending on the
device this could mean a failure to probe, a failure to function, or a system
deadlock. This is an unfortunate problem, but one that we can work around on a
case-by-case basis.

For new bindings, I see no reason to not have interrupt-names from the start,
as a required component of the binding.

Thanks,
Mark.
