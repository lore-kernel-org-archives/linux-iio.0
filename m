Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48947 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbbGKRqQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jul 2015 13:46:16 -0400
Message-ID: <55A15666.2050906@kernel.org>
Date: Sat, 11 Jul 2015 18:46:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Giuseppe Barba <giuseppe.barba@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Git repo to use for submitting patches
References: <CAPMRSivAzwTCoFqRw67FuxcLZD=d0YQBVonphjAY2gRNPL-g7g@mail.gmail.com> <CAEnQRZCQOZ_prM+KUCOfhxGSSKnQTMgR9wGDioPCukdU8cu0oQ@mail.gmail.com>
In-Reply-To: <CAEnQRZCQOZ_prM+KUCOfhxGSSKnQTMgR9wGDioPCukdU8cu0oQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/15 12:51, Daniel Baluta wrote:
> On Fri, Jul 10, 2015 at 2:42 PM, Giuseppe Barba
> <giuseppe.barba@gmail.com> wrote:
>> Hi,
>>
>> sorry I'm new in this list.
>> I wold like to submit some patches to add support for new sensor.
>> I'm not sure what repo I have to use for code rebasing. I've found:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>>
>> is it the correct one?
> 
> Yes. Please use 'testing' branch.
Actually that's a bit risky unless you need something in it.
It does get rebased.  I've been rather snowed under with day job stuff
last couple of weeks so haven't kept things as clean as they should be
but in theory:

1) togreg branch gets pushed out first as testing, but that's to let
   the autobuilders play with it rather than as an official branch to
   base anything on.
2) I fix up issues in testing found by the autobuilders and push it as
   as the togreg branch.
3) When enough stuff has built up I send a pull request to Greg KH
   and following that fastforward my tree.

Just to confuse things, fixes go via the fixes-togreg branch and make
it into the togreg branch only during the fastforward after Greg
has pulled in the previous patches to his tree.

So general principle is the togreg branch.  Actually for new sensors
that are unlikely to interact much with recent patches, staging/staging-next
is also usually fine, or even use Linus' mainline tree.

Jonathan
> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

