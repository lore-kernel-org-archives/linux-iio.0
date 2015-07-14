Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36662 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbGNJHr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jul 2015 05:07:47 -0400
Received: by lagw2 with SMTP id w2so2219932lag.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2015 02:07:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55A15666.2050906@kernel.org>
References: <CAPMRSivAzwTCoFqRw67FuxcLZD=d0YQBVonphjAY2gRNPL-g7g@mail.gmail.com>
	<CAEnQRZCQOZ_prM+KUCOfhxGSSKnQTMgR9wGDioPCukdU8cu0oQ@mail.gmail.com>
	<55A15666.2050906@kernel.org>
Date: Tue, 14 Jul 2015 11:07:46 +0200
Message-ID: <CAPMRSitidtMgEJ52Wsg99WPbR4xet5QyQCD9pkpObbUmZyE=XQ@mail.gmail.com>
Subject: Re: Git repo to use for submitting patches
From: Giuseppe Barba <giuseppe.barba@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks. It's much more clear now.

2015-07-11 19:46 GMT+02:00 Jonathan Cameron <jic23@kernel.org>:
> On 10/07/15 12:51, Daniel Baluta wrote:
>> On Fri, Jul 10, 2015 at 2:42 PM, Giuseppe Barba
>> <giuseppe.barba@gmail.com> wrote:
>>> Hi,
>>>
>>> sorry I'm new in this list.
>>> I wold like to submit some patches to add support for new sensor.
>>> I'm not sure what repo I have to use for code rebasing. I've found:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>>>
>>> is it the correct one?
>>
>> Yes. Please use 'testing' branch.
> Actually that's a bit risky unless you need something in it.
> It does get rebased.  I've been rather snowed under with day job stuff
> last couple of weeks so haven't kept things as clean as they should be
> but in theory:
>
> 1) togreg branch gets pushed out first as testing, but that's to let
>    the autobuilders play with it rather than as an official branch to
>    base anything on.
> 2) I fix up issues in testing found by the autobuilders and push it as
>    as the togreg branch.
> 3) When enough stuff has built up I send a pull request to Greg KH
>    and following that fastforward my tree.
>
> Just to confuse things, fixes go via the fixes-togreg branch and make
> it into the togreg branch only during the fastforward after Greg
> has pulled in the previous patches to his tree.
>
> So general principle is the togreg branch.  Actually for new sensors
> that are unlikely to interact much with recent patches, staging/staging-next
> is also usually fine, or even use Linus' mainline tree.
>
> Jonathan
>>
>> thanks,
>> Daniel.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
