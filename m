Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34225 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbcE2TLa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 15:11:30 -0400
Subject: Re: [PATCH 1/2] iio: generic_buffer: Cleanup when receiving signals
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <082703f268f7b8b868704006d285d605cce5a784.1463759121.git.leonard.crestez@intel.com>
 <alpine.DEB.2.02.1605201752050.13052@pmeerw.net>
 <c7be250e-cc01-98ba-c211-36bbd154366e@kernel.org>
 <9de98860-1670-dbc2-b419-8e623deda6ea@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <481f5a02-6683-d8a1-b31d-2ea2011810f7@kernel.org>
Date: Sun, 29 May 2016 20:11:28 +0100
MIME-Version: 1.0
In-Reply-To: <9de98860-1670-dbc2-b419-8e623deda6ea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/05/16 17:10, Crestez Dan Leonard wrote:
> On 05/21/2016 07:28 PM, Jonathan Cameron wrote:
>> On 20/05/16 16:55, Peter Meerwald-Stadler wrote:
>>>
>>>> This also drops all the code freeing string buffers at the end of main.
>>>> Memory is freed when the process exits anyway so there's no point in
>>>> cluttering the code with all those gotos.
>>>
>>> well, it helps to see that all memory has been released when looking for 
>>> leaks :)
>>> e.g. valgrind becomes much less useful when the program exits with tons of 
>>> memory still allocated
>> Beyond that we are looking at code here that will get cut and paste into other
>> peoples applications - they might not pick up that it doesn't clean up properly
>> after itself.
>>
>> I'd much prefer to keep these explicit frees in place.
> 
> I think this would make more sense for a library (like libiio). But
> isn't the code in tools/iio merely an a test tool?
Absolutely - but as we all know test tool code gets copied when one is an hurry!
> 
> I submitted v2 which keeps the frees. It still simplifies them by
> relying on stuff like free(NULL) being allowed.
That's a nicer approach.

Jonathan
> 

