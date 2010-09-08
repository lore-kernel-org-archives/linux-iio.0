Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34348 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811Ab0IHPfL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Sep 2010 11:35:11 -0400
From: "Murphy, Dan" <dmurphy@ti.com>
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>,
	Andrew Chew <AChew@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"khali@linux-fr.org" <khali@linux-fr.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Date: Wed, 8 Sep 2010 10:34:46 -0500
Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
Message-ID: <C9D59C82B94F474B872F2092A87F26141272E7852C@dlee07.ent.ti.com>
References: <1283470837-18210-1-git-send-email-achew@nvidia.com>
 <0680EC522D0CC943BC586913CF3768C003C2018464@dbde02.ent.ti.com>
 <643E69AA4436674C8F39DCC2C05F763816B85AD0A9@HQMAIL03.nvidia.com>
 <0680EC522D0CC943BC586913CF3768C003C2018BD4@dbde02.ent.ti.com>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003C2018BD4@dbde02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Andrew
Do you know if AKM is updating their user space eCompass library to interface with IIO?

Dan

> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
> owner@vger.kernel.org] On Behalf Of Datta, Shubhrajyoti
> Sent: Wednesday, September 08, 2010 5:05 AM
> To: Andrew Chew; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> linux-i2c@vger.kernel.org
> Cc: akpm@linux-foundation.org; khali@linux-fr.org; Laxman Dewangan
> Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
> 
> 
> 
> > -----Original Message-----
> > From: Andrew Chew [mailto:AChew@nvidia.com]
> > Sent: Wednesday, September 08, 2010 4:37 AM
> > To: Datta, Shubhrajyoti; linux-kernel@vger.kernel.org; linux-
> > iio@vger.kernel.org; linux-i2c@vger.kernel.org
> > Cc: akpm@linux-foundation.org; khali@linux-fr.org; Laxman Dewangan
> > Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
> >
> > > > This is for the Asahi Kasei AK8975 3-axis magnetometer.  It
> > > resides within
> > > > the magnetometer section of the IIO subsystem, and
> > > implements the raw
> > > > magn_x,y,z attributes, as well as x,y,z factory calibration
> > > attributes.
> > > >
> > > Could you help me with the datasheet details.
> >
> > What do you mean by this?
> Could you share a link where the datasheet could be downloaded.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
