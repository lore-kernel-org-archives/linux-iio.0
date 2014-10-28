Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63683 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbaJ1MkX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Oct 2014 08:40:23 -0400
Received: by mail-wi0-f172.google.com with SMTP id d1so5640202wiv.5
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2014 05:40:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <544B73DD.2060802@kernel.org>
References: <1413985817-10867-1-git-send-email-roberta.dobrescu@gmail.com>
	<CAEnQRZC2=1NaCfFjA6=TVU936LUzApobOgi5wPEOw6S4q3T29Q@mail.gmail.com>
	<544B73DD.2060802@kernel.org>
Date: Tue, 28 Oct 2014 14:40:21 +0200
Message-ID: <CAEnQRZABCT=+X1-gqZmyBBNECmA_cwUY0whZvf1Orob_8tnfEg@mail.gmail.com>
Subject: Re: [OPW kernel] [PATCH v3] staging: iio: iio_event_monitor: Add
 support for missing IIO modifiers
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	opw-kernel <opw-kernel@googlegroups.com>,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 25, 2014 at 12:56 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 22/10/14 15:12, Daniel Baluta wrote:
>> On Wed, Oct 22, 2014 at 4:50 PM, Roberta Dobrescu
>> <roberta.dobrescu@gmail.com> wrote:
>>> This patch adds the missing IIO modifiers in event_is_known function
>>> and iio_modifier_names vector.
>>>
>>> Additionally, it removes duplicate name entries of IIO_MOD_LIGHT_BOTH
>>> and IIO_MOD_LIGHT_IR in iio_modifier_names.
>>>
>>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
>>
>> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
>>
> Applied to the togreg branch of iio.git - initially pushed out as
> testing for the autobuilders to play.

Hi,

FYI:

Please note that this patch is both in Greg's staging-testing [1]
and Jonathan's testing [2] tree.

thanks,
Daniel.

[1] https://git.kernel.org/cgit/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=0a6e2170dfcd2b17ae32ad91993edf2b77014137
[2] https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=a9bef750135cc261bfceff6840a30a3f357df8da
