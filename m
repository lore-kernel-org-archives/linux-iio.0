Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:47197 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759115Ab1EBOVg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2011 10:21:36 -0400
Message-ID: <4DBEBE7B.2080902@cam.ac.uk>
Date: Mon, 02 May 2011 15:23:55 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [RFC PATCH 0/2] staging:iio: add name_extend to allow for named
 channels
References: <1304000663-5176-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713AAF07290B@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713AAF07290B@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/11 14:05, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-04-28:
>> This is needed for the light sensors where we indicate what a given
>> sensor is measuring. It also came up in Michael's questions in the the
>> thread Oddities and how to handle them.  Also for that matter allows
>> us to put back the in0_supply_raw convention that got squashed in
>> moving to iio_chan_spec registration.
>>
>> What do people think?
> 
> Looks good to me... And actually needed for the ADE7758 driver cleanup.
> So it would be good if you could get this into your iio-onwards tree.
Will put it right after patch that introduces iio_chan_spec.
Need to run the interface changes in tsl2563 past the original
submitters before pushing the tsl2563 driver out.

> 
>> (this is rather rough and ready, but then it is an RFC ;)
>>
>> Jonathan Cameron (2):
>>   RFC add naming to channels
>>   Example of naming usage
>>  drivers/staging/iio/iio.h               |   26 +++-
>>  drivers/staging/iio/industrialio-core.c |   34 +++-
>>  drivers/staging/iio/light/tsl2563.c     |  323 +++++++++++------------
>>  -------- 3 files changed, 165 insertions(+), 218 deletions(-)
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 
> 

