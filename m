Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60422 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbbC1NpX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 09:45:23 -0400
Message-ID: <5516B071.4000301@kernel.org>
Date: Sat, 28 Mar 2015 13:45:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
CC: "outreachy-kernel@googlegroups.com"
	<outreachy-kernel@googlegroups.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/2] Staging: iio: Place driver in sleep mode on error
References: <cover.1426981797.git.cristina.opriceana@gmail.com>	<ac0d5b2399b00fe9763c7844c726ffad0a65df99.1426981797.git.cristina.opriceana@gmail.com>	<55169AD2.3080400@kernel.org> <CAFA9rWNH8nwSQv75eQMOdxNGgF6bEGOjDCLw5pvdoALUjkh2xA@mail.gmail.com>
In-Reply-To: <CAFA9rWNH8nwSQv75eQMOdxNGgF6bEGOjDCLw5pvdoALUjkh2xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/15 13:10, Cristina Georgiana Opriceana wrote:
> On Sat, Mar 28, 2015 at 2:13 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 22/03/15 00:26, Cristina Opriceana wrote:
>>> Put device in sleep mode if an error is encountered after
>>> initialization in order to avoid wasting power.
>> The patch title should definitely include the name of the driver in question!
>> Otherwise you'll not generally get reviews from the relevant people.
>> Staging:iio:hmc5843 Place driver in sleep mode on error during probe.
>>
>> Also try to cc relevant people and the relevant list.
>> See MAINTAINERS and you'll notice we have both a list and a
>> set of designated reviewers who would like to be cc'd on IIO patches.
> 
> Okay, thanks for your feedback, I'll keep that in mind for the future work
> because Greg has already merged this on his staging-next branch.
Fair enough!

J
> 
> Thanks,
> Cristina
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

