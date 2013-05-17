Return-Path: <lars@metafoo.de>
Message-ID: <519614CA.5040702@metafoo.de>
Date: Fri, 17 May 2013 13:30:18 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Denis Ciocca <denis.ciocca@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: Use buffer without trigger
References: <CAEE_umrLpNJo1kMbLtktK0RH6WCKCEYR+yiTiyPJu_8G3coE7A@mail.gmail.com> <CAEE_umq7aC5=HWAW_2N=XsLJ0y6YqBojjN0Awm3BuGmqHSzrsw@mail.gmail.com> <51927AEF.6080107@metafoo.de> <2076388.y5Y0d24KYt@ctocwl0124>
In-Reply-To: <2076388.y5Y0d24KYt@ctocwl0124>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/17/2013 01:28 PM, Denis CIOCCA wrote:
> I've tried to register a buffer on one iio device, but when I try to enable it 
> the error massage is about the no trigger available.
> I don't want a trigger for this device, I want use only one trigger of another 
> iio device for all. It is possible?
> Thanks,
> 
> Denis

Yes, but you still have to assign the trigger to the device in sysfs.

- Lars
