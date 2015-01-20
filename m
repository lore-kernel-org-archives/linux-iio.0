Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36932 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbATUhY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jan 2015 15:37:24 -0500
Message-ID: <54BEBC80.1090608@kernel.org>
Date: Tue, 20 Jan 2015 20:37:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	James Hartley <james.hartley@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>, robh+dt@kernel.org,
	Mark.Rutland@arm.com, knaack.h@gmx.de
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
Subject: Re: [PATCH v7 0/3] iio: Add Cosmic Circuits ADC support
References: <1420577257-10846-1-git-send-email-ezequiel.garcia@imgtec.com> <54B133FE.1020808@kernel.org> <54BE33FB.6020800@imgtec.com>
In-Reply-To: <54BE33FB.6020800@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/01/15 10:54, Ezequiel Garcia wrote:
> 
> 
> On 01/10/2015 11:15 AM, Jonathan Cameron wrote:
>> On 06/01/15 20:47, Ezequiel Garcia wrote:
>>> This series add the support for an ADC IP block from Cosmic Circuits.
>>> The patchset is based on v3.19-rc3.
>>>
>>> As agreed with Rob, this series drops the vendor prefix in the
>>> adc-reserved-channels DT property. This property is generic enough to
>>> be used in other drivers (at91 is a potential candidate).
>>>
>>> A follow-up patch can use the property in at91 and add it to the
>>> IIO generic bindings.
>> I'm happy - will let this sit for a little while to let Harmut say
>> if wants to take another look (or give a reviewed-by or similar).
>>
> 
> Hi Jonathan,
> 
> As Harmut gave a Reviewed-by, I'm wondering if you can pick this sooner
> than later, so we don't miss next window.
> 
> Thanks a lot!
> 
Hi, I'm afraid that I'm a little stalled on sending it on because Greg
hasn't yet picked up my last pull request.  In the mean time I've applied
it to the branch that will get rebased once he's taken that and pushed it
out as testing.

Jonathan
