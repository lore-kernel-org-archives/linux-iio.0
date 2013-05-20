Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:32819 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755434Ab3ETJ6z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 20 May 2013 05:58:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1UeMrm-0004UR-5g
	for linux-iio@vger.kernel.org; Mon, 20 May 2013 11:58:54 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2013 11:58:54 +0200
Received: from j.anaszewski by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2013 11:58:54 +0200
To: linux-iio@vger.kernel.org
From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [NEW DRIVER] iio: lps331ap: Add new driver for the device
Date: Mon, 20 May 2013 11:58:43 +0200
Message-ID: <5199F3D3.5010704@samsung.com>
References: <1368176965-23190-1-git-send-email-j.anaszewski@samsung.com> <1368176965-23190-2-git-send-email-j.anaszewski@samsung.com> <5197555D.8070801@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jacek Anaszewski
	<public-j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@plane.gmane.org>,
	public-linux-iio-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org,
	public-matteo.dameno-qxv4g6HH51o@plane.gmane.org,
	public-carmine.iascone-qxv4g6HH51o@plane.gmane.org,
	public-kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@plane.gmane.org,
	public-s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@plane.gmane.org
In-Reply-To: <5197555D.8070801@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/18/2013 12:18 PM, Jonathan Cameron wrote:
> On 05/10/2013 10:09 AM, Jacek Anaszewski wrote:
>> Add new driver for the barometer device. The driver is
>> compiliant with IIO framework, and exposes two channels
>> for reading the pressure and the temperature. The output
>> data can be read either in 'one shot' mode or by exploiting
>> IIO events.
>>
>> Signed-off-by: Jacek Anaszewski<j.anaszewski@samsung.com>
>> Reviewed-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> Hi All,
>
> As I said the other day I'll review this driver irrespective
> of what is going on with Denis' alternative.  It is a useful
> exercise to look at alternative drivers for parts anyway
> and I hope the feedback may prove useful.
>
> This is mostly a nice driver.  Few bits and bobs inline.
>
> There are some places where a bit of simple reorganization can
> lead to code that is easier to review (thus making me happy).
> You can also hopefully assume the core code isn't calling
> your callbacks with invalid combinations so drop some error
> checking (if it is I certainly want to know about it!)
>
> Also I'd like to see the stanard i2c helper functions used
> (using the simple byte and word ones where possible).
> That will reduce the length of the code a fair bit by
> not reinventing the wheel...
>
> All in all a driver that did not make for an unpleasant hour on a
> Saturday morning :)
>
> Jonathan

Hi Jonathan,

Thanks for the thorough review. I will certainly keep your remarks
in mind and apply them in my future patches.

Thanks,
Jacek

