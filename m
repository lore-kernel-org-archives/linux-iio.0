Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49956 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbaJYT0C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 25 Oct 2014 15:26:02 -0400
Message-ID: <544B73DD.2060802@kernel.org>
Date: Sat, 25 Oct 2014 10:56:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
CC: opw-kernel <opw-kernel@googlegroups.com>, linux-iio@vger.kernel.org
Subject: Re: [OPW kernel] [PATCH v3] staging: iio: iio_event_monitor: Add
 support for missing IIO modifiers
References: <1413985817-10867-1-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZC2=1NaCfFjA6=TVU936LUzApobOgi5wPEOw6S4q3T29Q@mail.gmail.com>
In-Reply-To: <CAEnQRZC2=1NaCfFjA6=TVU936LUzApobOgi5wPEOw6S4q3T29Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/10/14 15:12, Daniel Baluta wrote:
> On Wed, Oct 22, 2014 at 4:50 PM, Roberta Dobrescu
> <roberta.dobrescu@gmail.com> wrote:
>> This patch adds the missing IIO modifiers in event_is_known function
>> and iio_modifier_names vector.
>>
>> Additionally, it removes duplicate name entries of IIO_MOD_LIGHT_BOTH
>> and IIO_MOD_LIGHT_IR in iio_modifier_names.
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
> 
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play.

Jonathan
