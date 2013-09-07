Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58386 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab3IGUY4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2013 16:24:56 -0400
Message-ID: <522B99B1.1050301@kernel.org>
Date: Sat, 07 Sep 2013 22:25:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v10] Add Microchip MCP3422/3/4 high resolution ADC
References: <1378130401-22367-1-git-send-email-angelo.compagnucci@gmail.com> <522B9889.1060508@kernel.org>
In-Reply-To: <522B9889.1060508@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/13 22:20, Jonathan Cameron wrote:
> On 09/02/13 15:00, Angelo Compagnucci wrote:
>> Hi Jonathan,
>>
>> Kawabonga! It works! Really, but really (no joke here!) thank you
>> for your precious support and sorry for not being so smart to
>> understand what you were saying me. Sorry again for being so pedantic!
>>
>> I'm planning to write a tutorial based on my journey, something like
>> "Howto write your first IIO LDD", what do you think?
> 
> An excellent thing to do.  There has been a fair bit of discussion about how to
> get new hobbyist contributors to the kernel as part of the nomination process
> for the kernel summit.  One of the things I suggested was that IIO was a good place
> for people to get started (beyond the trivial cleanup or fix that gets a lot of people
> their first patch).  I suggested that a tutorial such as you describe (perhaps
> adding more bells and whistles (as later steps) that we keep up to date with api
> changes etc would be an excellent resource.
> 
> The tutorial you are suggesting sounds like an excellent first step to such
> a (perhaps?) more general resource if you are willing to have it used that way?
> 
>>
>> Attached here, there is the latest version of the patch based on jour suggestions.
>> I think all of your concerns are solved now.
> They are indeed.  Few new trivial bits that I have fixed up in the merge though.
> 
> 1) Don't have this 'comment' stuff here in the email.  If you put it below the
> --- then I don't end up editting it out. Much as I'd like to have kernel logs
> with extensive TMHT references probably best not ;)
> 
> Also, bodging in my suggestions left some white space mess that I probably introduced
> by writing some of those snippets of code in my email client.
> 
I forgot to mention that every corner of the kernel has it's own unique patch title scheme
so you always need to take a look at other recent patches in the relevant area and copy the
form.  In the case of IIO I pinched it from somewhere else (can't remember where ;) and
went with
'iio: adc: New driver for... ' for the initial patch introducing the driver.
'iio: adc: mcp3422 ....' for follow up patches.

Few more points for the end of any tutorial!


> Anyhow take a look at the tree and check I didn't mess anything up!
>>
>> Thank you again!
>>
>> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> Applied to the togreg branch of iio.git
> 
