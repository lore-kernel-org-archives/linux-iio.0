Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:57308 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932382AbbHXGyL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 24 Aug 2015 02:54:11 -0400
Subject: Re: DAC switch between current and voltage mode
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	<lars@metafoo.de>, <jic23@jic23.retrosnub.co.uk>
References: <715D9F6A60DF2F458F39683D45F6609A7E22F4FC@VMPREVAS1.prevas.se>
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <55DABD39.5010804@prevas.dk>
Date: Mon, 24 Aug 2015 08:44:09 +0200
MIME-Version: 1.0
In-Reply-To: <715D9F6A60DF2F458F39683D45F6609A7E22F4FC@VMPREVAS1.prevas.se>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars-Peter

Sorry the write again. Is the possible with the current iio interface to 
switch a dac from voltage to current mode from userspace?
If not, will upstream be interrested in a patch if it's possible?

Regards
Sean Nyekjær

On 2015-08-20 11:57, Sean Nyekjær wrote:
> Hi all
>
> I'm in the process of creating a custom BSP with an ad5755 dac. It an requirement to be able to switch between voltage and current mode per channel from userspace.
> Is it possible with the current iio interface?
> Is there a feature in the pipeline where it's possible to do this switch?
>
> Regards
> Sean Nyekjær--
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

