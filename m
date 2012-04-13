Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:56170 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab2DMKjk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 06:39:40 -0400
Message-ID: <4F880268.8080800@cam.ac.uk>
Date: Fri, 13 Apr 2012 11:39:36 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 13/13] staging:iio: drop procesed_val element of chan_spec.
References: <1334311471-23054-1-git-send-email-jic23@kernel.org> <1334311471-23054-14-git-send-email-jic23@kernel.org> <4F880205.1030001@metafoo.de>
In-Reply-To: <4F880205.1030001@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/13/2012 11:37 AM, Lars-Peter Clausen wrote:
> On 04/13/2012 12:04 PM, Jonathan Cameron wrote:
>> [...]
>> +<<<<<<<  HEAD
>>    *			correspond to the first name that the channel is referred
>>    *			to by in the datasheet (e.g. IND), or the nearest
>>    *			possible compound name (e.g. IND-INC).
>>    * @processed_val:	Flag to specify the data access attribute should be
>>    *			*_input rather than *_raw.
>> +=======
>> + *			correspond to the first name that the channel is
>> + *			referred to by in the datasheet (e.g. IND), or the
>> + *			nearest	possible compound name (e.g. IND-INC).
>> +>>>>>>>  adbde46... staging:iio: drop procesed_val element of chan_spec.
>>   [...]
> Looks like something went wrong here.
>
Gah.  I would be in the comment wouldn't it....   Will fix for next 
version as that'll not effect
testing and the other patches.
