Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58452 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab2ALTWN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2012 14:22:13 -0500
Message-ID: <4F0F3301.4080706@kernel.org>
Date: Thu, 12 Jan 2012 19:22:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Palande, Ameya" <ameya.palande@ti.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: staging: iio: add iio information
References: <1326215362-4905-1-git-send-email-ameya.palande@ti.com> <CAHFNHeVvx5KWh48xVJuPsN=gw5TsR_VQUJgC_j58K8t8oQOfYw@mail.gmail.com>
In-Reply-To: <CAHFNHeVvx5KWh48xVJuPsN=gw5TsR_VQUJgC_j58K8t8oQOfYw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/12/2012 07:09 PM, Palande, Ameya wrote:
> Any update on this?
I had a feeling there wa already an entry and indeed there is

STAGING - INDUSTRIAL IO
M:	Jonathan Cameron <jic23@cam.ac.uk>
L:	linux-iio@vger.kernel.org
S:	Odd Fixes
F:	drivers/staging/iio/

Sorry first read this on my phone without a tree to hand then forgot to
do anything about it later!

However, you have reminded me that I'm probably going to loose access to
that email address shortly so should do something about these listing!
Jonathan
> 
> On Tue, Jan 10, 2012 at 9:09 AM, Ameya Palande <ameya.palande@ti.com> wrote:
>> Signed-off-by: Ameya Palande <ameya.palande@ti.com>
>> ---
>>  MAINTAINERS |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 230b5e1..5e0da69 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3285,6 +3285,12 @@ S:       Maintained
>>  F:     net/ieee802154/
>>  F:     drivers/ieee802154/
>>
>> +IIO SUBSYSTEM AND DRIVERS
>> +M:     Jonathan Cameron <jic23@cam.ac.uk>
>> +L:     linux-iio@vger.kernel.org
>> +S:     Maintained
>> +F:     drivers/staging/iio/
>> +
>>  IKANOS/ADI EAGLE ADSL USB DRIVER
>>  M:     Matthieu Castet <castet.matthieu@free.fr>
>>  M:     Stanislaw Gruszka <stf_xl@wp.pl>
>> --
>> 1.7.5.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

