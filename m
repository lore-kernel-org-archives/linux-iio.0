Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-068.synserver.de ([212.40.185.68]:1046 "EHLO
	smtp-out-068.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbGSJyP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 05:54:15 -0400
Message-ID: <55AB73C3.5020206@metafoo.de>
Date: Sun, 19 Jul 2015 11:54:11 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Cristina Opriceana <cristina.opriceana@gmail.com>
CC: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@intel.com
Subject: Re: [PATCH] iio: Fix iio_validate_scan_mask_oneshot function name
 typo
References: <7d56ec6a8a6fdd76d8cc9abf4330c34061873920.1437229669.git.cristina.opriceana@gmail.com> <55AB72A3.7080105@kernel.org>
In-Reply-To: <55AB72A3.7080105@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/19/2015 11:49 AM, Jonathan Cameron wrote:
> On 18/07/15 15:31, Cristina Opriceana wrote:
>> Rename function to iio_validate_scan_mask_oneshot() since it's used to
>> validate that only one channel is selected.
>>
>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> I'm sure Lars (who I think named it?) will come back with a fuller response, but
> I believe the naming (if not necessarily clear!) was deliberate.
>
> one hot - as in only one channel is enabled at a time.
> oneshot - only a single reading of all channels is taken
> (like a one shot interrupt).

Yes. See https://en.wikipedia.org/wiki/One-hot

Thanks.
