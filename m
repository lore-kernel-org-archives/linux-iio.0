Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48809 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbbGKR1l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jul 2015 13:27:41 -0400
Message-ID: <55A1520C.5080401@kernel.org>
Date: Sat, 11 Jul 2015 18:27:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Ana Calinov <ana.calinov@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: kxcjk-1013: Remove blank lines
References: <20150708124442.GA10598@spook> <CAEnQRZCem_5Z8rnEsFY4p7t2UFfvzaHDgepFNsSv33YHid9Mkg@mail.gmail.com>
In-Reply-To: <CAEnQRZCem_5Z8rnEsFY4p7t2UFfvzaHDgepFNsSv33YHid9Mkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/07/15 13:56, Daniel Baluta wrote:
> On Wed, Jul 8, 2015 at 3:44 PM, Ana Calinov <ana.calinov@gmail.com> wrote:
>> This patch fixes the the following errors given by
>> checkpatch.pl with --strict:
>> Please don't use multiple blank lines.
>> Blank lines aren't necessary after an open brace '{'.
>>
>> Signed-off-by: Ana Calinov <ana.calinov@gmail.com>
> 
> 
> Looks good to me.
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
> 
> Thanks Ana!
> 
> Daniel.
> 
Applied to the togreg branch of iio.git.  Will push out
as testing for the autobuilders to play with it.

A sensible checkpatch based cleanup. Thanks

Jonathan
