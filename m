Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:58689 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab1JEO00 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2011 10:26:26 -0400
Message-ID: <4E8C6B0C.7040504@cam.ac.uk>
Date: Wed, 05 Oct 2011 15:34:52 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>,
	"manuel.stahl@iis.fraunhofer.de" <manuel.stahl@iis.fraunhofer.de>
Subject: Re: [PATCH 00/11] IIO: resolvers - first round of cleanups.
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177146E73435B7@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E73435B7@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/11 07:58, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-09-30:
>> Hi All,
>>
>> Mostly straight forward, but that change I suggested yesterday
>> IIO_GYRO -> IIO_ANGL_VEL and in_gyro_x_* -> in_anglvel_x_*
>> is in here.  I'm interested to hear peoples opinions on that
>> in particular.
>>
>> Note the ad2s1210 is still definitely a work in progress.
>> There are numerous weird and wonderful corners of its abi
>> a the moment that need sorting out.
>>
>> Thanks,
>>
>> Jonathan
> 
> Hi Jonathan,
> 
> Looks good to me. Thanks!
Gone to Greg along with the ad7314 removal patch.

Jonathan

