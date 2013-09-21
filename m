Return-Path: <lars@metafoo.de>
Message-ID: <523D78CB.5030001@metafoo.de>
Date: Sat, 21 Sep 2013 12:45:31 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/10] iio: Stop sampling when the device is removed
References: <1379534574-11213-1-git-send-email-lars@metafoo.de> <523D84D7.8010500@kernel.org>
In-Reply-To: <523D84D7.8010500@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/21/2013 01:36 PM, Jonathan Cameron wrote:
> On 09/18/13 21:02, Lars-Peter Clausen wrote:
>> Make sure to stop sampling when the device is removed, otherwise it will
>> continue to sample forever.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Applied to the fixes togreg branch of iio.git
>

1-4 can go in as is, I've reworked and made some fixes the others though.

- Lars
