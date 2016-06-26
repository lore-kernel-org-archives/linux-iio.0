Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47295 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbcFZOxU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 10:53:20 -0400
Subject: Re: [PATCH 3/3] iio: potentiometer: mcp4531: Add device tree binding
To: Florian Vaussard <florian.vaussard@heig-vd.ch>,
	Peter Rosin <peda@axentia.se>
References: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492137-32683-4-git-send-email-florian.vaussard@heig-vd.ch>
 <bf4dbd64-aac8-aba3-ec5c-4cd4d0e848f6@axentia.se>
 <829a4507-39d7-e04a-9672-6309def89ee2@heig-vd.ch>
 <dfdbc7dd-8457-c0ef-9f0e-e2c1d96e5b11@axentia.se>
 <576BA2DD.2060501@heig-vd.ch>
Cc: devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6d0f2f31-7d9f-5b6b-b244-d976c4d3cd0d@kernel.org>
Date: Sun, 26 Jun 2016 15:53:14 +0100
MIME-Version: 1.0
In-Reply-To: <576BA2DD.2060501@heig-vd.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/06/16 09:50, Florian Vaussard wrote:
> Hello Peter,
> 
> On 06/22/2016 09:06 AM, Peter Rosin wrote:
>> On 2016-06-22 08:22, Florian Vaussard wrote:
>>> Hello Peter,
>>>
>>> Le 21. 06. 16 à 09:51, Peter Rosin a écrit :
>>>> That is, if you need this patch at all, see my reply to 2/3...
>>>>
>>>
>>> This seems necessary in order to have the vendor ID in the compatible string.
>>
>> Hmm, I don't think so. The way I read the response from Rob was that
>> *my* device tree snippet should not assume that the i2c subsystem
>> ignores the vendor. So, I think that even w/o this patch a DT entry
>> like
>>
>> 		mcp4651-104@28 {
>> 			compatible = "microchip,mcp4651-104";
>> 			reg = <0x28>;
>> 		};
>>
>> will work, precisely since i2c ignores the microchip, part (and thus
>> allows you to omit/misspell it). I.e. I think that Rob is concerned
>> with how the DT is documented/defined, and not so much about how it
>> is then implemented in Linux.
>>
> 
> The way that I read Rob's reply is reverse: you should not rely on the matching
> done by i2c subsystem and provide a proper of_device_id table instead.
The original 'quirk' of matching in i2c and spi based on the part number
alone has been the source of much grief.  Unfortunately it is there
and there are numerous device trees out there using it.

The preferred option is a nice conventional table as you added in patch 2.

We just haven't gotten round to updating all the drivers yet and as it
'works' right now there is little motivation to do it unless someone is
working on the driver as you are.
> 
> I think that ignoring the vendor when matching the compatible, like what is
> currently done by the i2c subsystem, is bad. What happens if you have two chips
> from two companies with the same name (yes it happens)? You may need different
> data to address the small specificities of each chip, or even worse a different
> driver at all. This implies that we should explicitly match the vendor as well,
> otherwise we would be unable to cope with such cases.
Exactly and it's already happened I believe... With two totally different parts
having the same part number rather than the similar ones case.
> 
> Moreover, if we look at the current i2c drivers, a whole bunch of them already
> have a of_device_id table:
> 
> (on v4.6)
> 
> $ git grep -l i2c_device_id | wc -l
> 636
> $ git grep -l i2c_device_id | xargs grep -l 'of_device_id' | wc -l
> 197
> 
> Currently 30% of all i2c drivers explicitly declare DT compatible strings. And I
> am sure that this number will keep increasing as drivers are converted to DT.
> 
> Regards,
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

