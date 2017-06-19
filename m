Return-Path: <SRS0=9dm9=5Y=gmail.com=olivier.dugas.1@kernel.org>
Subject: Re: SI1133 light sensor: Is there anything to refer to?
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: jic23@kernel.org, leonard.crestez@intel.com, linux-iio@vger.kernel.org
References: <938fc03d-63d9-de58-d536-de1cd51c732d@gmail.com>
 <alpine.DEB.2.20.1706191652040.15475@vps.pmeerw.net>
From: Olivier Dugas <olivier.dugas.1@gmail.com>
Message-ID: <ec438ed1-2b6a-0f23-ed9d-eb6bcbbd3b05@gmail.com>
Date: Mon, 19 Jun 2017 12:04:07 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1706191652040.15475@vps.pmeerw.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Excellent news. I'll keep a watch for this new driver to show up.
In the meantime, we just got the sensor to respond correctly using 
i2cget|set commands.

FYI, the issue we had was that the reset value of ADCCONFIGx is not 0x00 
(as specified by the datasheet), but 0x0f, which selected no photodiode. 
Hence, we received only noise values.

Thanks a lot and have a good day

-- 

Olivier Dugas

On 17-06-19 11:10 AM, Peter Meerwald-Stadler wrote:
> Hello Olivier,
>
>> We've recently been trying to make the SI1133 light sensor work according to
>> what's written in its datasheet. Unfortunately many questions remain and the
>> si1145.c driver seems largely different from si1133. We believe that any code
>> sample would be of a great help. Are you aware of any driver, unmerged patch
>> or other code sample for this sensor?
> the si1133 belongs in the same family as the si1153 which has a different
> register layout than the previous chips, so I think a separate driver is
> needed
>
> I do have an eval board for the si1153 and started a driver, but it's not
> ready for submission (yet), the si1133 should be a lot simpler than the
> si1153
>
> regards, p.
>
