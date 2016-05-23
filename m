Return-Path: <leonard.crestez@intel.com>
Subject: Re: [PATCH 1/2] iio: generic_buffer: Cleanup when receiving signals
To: Jonathan Cameron <jic23@kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <082703f268f7b8b868704006d285d605cce5a784.1463759121.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1605201752050.13052@pmeerw.net>
 <c7be250e-cc01-98ba-c211-36bbd154366e@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <9de98860-1670-dbc2-b419-8e623deda6ea@intel.com>
Date: Mon, 23 May 2016 19:10:52 +0300
MIME-Version: 1.0
In-Reply-To: <c7be250e-cc01-98ba-c211-36bbd154366e@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 05/21/2016 07:28 PM, Jonathan Cameron wrote:
> On 20/05/16 16:55, Peter Meerwald-Stadler wrote:
>>
>>> This also drops all the code freeing string buffers at the end of main.
>>> Memory is freed when the process exits anyway so there's no point in
>>> cluttering the code with all those gotos.
>>
>> well, it helps to see that all memory has been released when looking for 
>> leaks :)
>> e.g. valgrind becomes much less useful when the program exits with tons of 
>> memory still allocated
> Beyond that we are looking at code here that will get cut and paste into other
> peoples applications - they might not pick up that it doesn't clean up properly
> after itself.
> 
> I'd much prefer to keep these explicit frees in place.

I think this would make more sense for a library (like libiio). But
isn't the code in tools/iio merely an a test tool?

I submitted v2 which keeps the frees. It still simplifies them by
relying on stuff like free(NULL) being allowed.

-- 
Regards,
Leonard
