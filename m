Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:38595 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753179Ab3JULh1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2013 07:37:27 -0400
Date: Mon, 21 Oct 2013 12:37:11 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lukasz Czerwinski <l.czerwinski@samsung.com>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"denis.ciocca@st.com" <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC v2 PATCH 02/14] iio: st_accel: Add dt bindings
Message-ID: <20131021113710.GE8144@kartoffel>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
 <1380299538-22047-3-git-send-email-l.czerwinski@samsung.com>
 <524AED0A.6030707@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <524AED0A.6030707@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Oct 01, 2013 at 04:40:58PM +0100, Jonathan Cameron wrote:
> On 09/27/13 17:32, Lukasz Czerwinski wrote:
> > Add OF support for the st_accel.
> > 
> > Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> The dev name changes result in an ABI change.  This was
> being discussed deep in a thread related to Lee's patches
> but I don't think has yet been resolved.
> 
> The issue is that they are exposed to userspace via sysfs
> by both the i2c subsystem and IIO.
> 
> My gut feeling is we are stuck with the underscores but no one has
> definitively come down and said we are find to leave them be
> and break with DT conventions.

I would very much prefer to not have Linux infrastructure problems affect the
device tree.

> 
> We can't even play games with having different naming in the device
> tree and exposed to usespace because there are already DT files
> using the implicit i2c bindings.

We could fix this up my adding explicit (but marked legacy-only/deprecated)
of_device_id table entries for the implicit compatible strings already in use.

Once that's done we can try to clean up the implict match logic. We could at
least prevent implicit matches for drivers with of_match_id tables.

Thanks,
Mark.
