Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-052.synserver.de ([212.40.185.52]:1040 "EHLO
	smtp-out-052.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756240Ab3AIOid (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2013 09:38:33 -0500
Message-ID: <50ED8112.5020808@metafoo.de>
Date: Wed, 09 Jan 2013 15:39:14 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: IIO Trigger HR-Timer
References: <50ED4E4E.8030603@st.com>
In-Reply-To: <50ED4E4E.8030603@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2013 12:02 PM, Denis CIOCCA wrote:
> Hi all,
> 
> Some time ago, I had seen one patch for hr_timer trigger for 
> asynchronous data acquisition.
> A lot of customers use the asynchronous data acquisition to avoid wired 
> interrupt lines.
> Can I create in st_sensors library one hr_trigger for this purpose or 
> someone add this patch to the main iio trigger code?
> 
> Thanks,
> Denis--

Hi,

I've pushed a version of the hr_timer trigger rebased onto iio/togreg to
https://github.com/lclausen-adi/linux-2.6/tree/iio_highres_timer

The trigger works fine, but it needs to be reworked before it can go into
upstream. The issue is that it is currently instantiated via a platform
device while it should be instantiated using some other method, for example
sysfs.

- Lars
