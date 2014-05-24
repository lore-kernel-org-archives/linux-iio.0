Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32951 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbaEXKlz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 May 2014 06:41:55 -0400
Message-ID: <538077DC.7010700@kernel.org>
Date: Sat, 24 May 2014 11:43:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>,
	linux-iio@vger.kernel.org
Subject: Re: format string mismtach
References: <537A2702.8090803@gmx.de>
In-Reply-To: <537A2702.8090803@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/14 16:45, Toralf Förster wrote:
> Hello,
>
> cppcheck reported :
>
> [drivers/staging/iio/Documentation/iio_utils.h:321]: (warning) %u in format string (no. 1) requires 'unsigned int *' but the argument type is 'int *'.
> [drivers/staging/iio/Documentation/iio_utils.h:353]: (warning) %u in format string (no. 1) requires 'unsigned int *' but the argument type is 'int *'.
>
> trivial patches IMO - are they already queued up ?
>
Nope.  Feel free to submit such a patch. If not I'll get around to
it eventually!
