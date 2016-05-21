Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46550 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbcEUQjS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 May 2016 12:39:18 -0400
Subject: Re: [RFT PATCH] iio: magn: Add support for BMM150 magnetometer
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1461674398-18374-1-git-send-email-daniel.baluta@intel.com>
 <CAKi4VA+JgdEa9owULm_hg8fiJGMCwv286y-0J-rRX_Ukups8QQ@mail.gmail.com>
 <eeecf854-b308-7e7a-b711-d435a4c95c2f@kernel.org>
 <CAEnQRZChKkc6VS6NHPcQADns_npzv-1OH72aqNM0aB6qFoPP+g@mail.gmail.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cd2c6862-4fb6-1693-85a4-1f0a984b9536@kernel.org>
Date: Sat, 21 May 2016 17:39:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZChKkc6VS6NHPcQADns_npzv-1OH72aqNM0aB6qFoPP+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/16 15:01, Daniel Baluta wrote:
> On Wed, May 4, 2016 at 1:26 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 27/04/16 15:55, Lucas De Marchi wrote:
>>> On Tue, Apr 26, 2016 at 9:39 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>>> BMM150 is register compatible with magnetometer part of
>>>> BMC156.
>>>>
>>>> Datasheet is at:
>>>> http://www.mouser.com/ds/2/783/BST-BMM150-DS001-01-786480.pdf
>>>>
>>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>>> ---
>>>> Lucas let me know if it works for you. I don't have yet the BMM150 evaluation
>>>> board. It should be available in few weeks.
>>>>
>>>> I'll just leave this patch here in case anyone steps in to test it.
>>>
>>> It will take a while for my test board to arrive here, so expect delay
>>> on testing this.
>> I'm dropping this from my list of outstanding patches for now.
>> It'll resurface when you guys restart the thread.
> 
> Got the shuttle board and basic tests with generic_buffer seem to work fine.
> 
> Jonathan can you pick this up if no other comments?
Done.  It might be worth a follow up to list the supported parts in the Kconfig
description.  Given they aren't listed already, I'm not going to add this one
on it's own and it would make little sense to add them all in this patch.
> 
> thanks,
> Daniel.
> 

