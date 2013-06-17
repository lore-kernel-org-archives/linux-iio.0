Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33304 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755726Ab3FQN3T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 17 Jun 2013 09:29:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1UoZUk-0006y9-LH
	for linux-iio@vger.kernel.org; Mon, 17 Jun 2013 15:29:18 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2013 15:29:18 +0200
Received: from j.anaszewski by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2013 15:29:18 +0200
To: linux-iio@vger.kernel.org
From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH 1/1] iio: Added ST-sensors platform data to select the
 DRDY interrupt pin
Date: Mon, 17 Jun 2013 15:29:09 +0200
Message-ID: <kpn2uu$6u1$1@ger.gmane.org>
References: <1369042727-11210-1-git-send-email-denis.ciocca@st.com> <1369042727-11210-2-git-send-email-denis.ciocca@st.com> <519D39D5.2010600@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <519D39D5.2010600@kernel.org>
Cc: 0@plane.gmane.org, 0@plane.gmane.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/22/2013 11:34 PM, Jonathan Cameron wrote:
> On 05/20/2013 10:38 AM, Denis CIOCCA wrote:
>> This patch add support to redirect the DRDY interrupt on INT1 or INT2
>> on accelerometer and pressure sensors.
>>
>> Signed-off-by: Denis Ciocca<denis.ciocca@st.com>
> Looks good in principal, but as it is dependent on the pressure sensor
> patch I'll wait for a refresh of this after remaining points in that driver
> review are addressed.  As a trivial side point, there are a few whitespace
> and formatting changes in here, which whilst worthy on the hole, should not
> be in a patch adding new functionality liek this one.
>

Hi Jonathan, Dennis,

The pressure sensor patch is applied to the togreg branch but I don't 
see the above one there. I think that the only reasons are those 
formatting issues? I am waiting for this patch to be applied, as
I want to add support for device tree basing on it.

Thanks,
Jacek

