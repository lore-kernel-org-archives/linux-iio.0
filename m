Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-165.synserver.de ([212.40.185.165]:1084 "EHLO
	smtp-out-160.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752532Ab3HDN3Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 09:29:16 -0400
Message-ID: <51FE5764.5090304@metafoo.de>
Date: Sun, 04 Aug 2013 15:30:12 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jacek Anaszewski <j.anaszewski@samsung.com>,
	linux-iio@vger.kernel.org, denis.ciocca@st.com,
	devicetree-discuss@lists.ozlabs.org, l.czerwinski@samsung.com,
	maxime.ripard@free-electrons.com,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v2] iio: lps331ap: Add support for DT
References: <1374240981-13560-1-git-send-email-j.anaszewski@samsung.com> <1374240981-13560-2-git-send-email-j.anaszewski@samsung.com> <51FE4117.3040404@kernel.org>
In-Reply-To: <51FE4117.3040404@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/2013 01:55 PM, Jonathan Cameron wrote:
> On 07/19/13 14:36, Jacek Anaszewski wrote:
>> This patch adds DT support for the lps331ap barometer
>> sensor.
>>
>> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> This makes sense to me and looks similar to that in existing bindings
> hence,
> 
> Applied to the togreg branch of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> 
> Note I am one of those maintainers who has very limited knowledge of device
> tree so am basing this decision on the 'it looks like existing mappings' rather
> than any deep understanding.

The bindings are not OK.

[...]
>> +  - drdy-int-pin : redirect DRDY on pin INT1 (1) or pin INT2 (2) (u8)

This is a vendor specific property, so it needs a vendor prefix. Also
abbreviations are kind of frowned upon for dt property names. So
'st,data-ready-interrupt-pin' is probably a better name.

>> +  - interrupt-parent : phandle to the interrupt map subnode
>> +  - interrupts : interrupt mapping for LPS331AP interrupt sources:
>> +		 2 sources: 0 - data ready, 1 - threshold event
>> +  - irq-map : irq sub-node defining interrupt map
>> +	      (all properties listed below are required):
>> +      - #interrupt-cells : should be 1
>> +      - #address-cells : should be 0
>> +      - #size-cells : should be 0
>> +      - interrupt-map : table of entries consisting of three child elements:
>> +	  - unit_interrupt_specifier - 0 : data ready, 1 : threshold event
>> +	  - interrupt parent phandle
>> +	  - parent unit interrupt specifier consisiting of two elements:
>> +	      - index of the interrupt within the controller
[...]
