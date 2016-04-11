Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41759 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792AbcDKTHm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 11 Apr 2016 15:07:42 -0400
Date: Mon, 11 Apr 2016 14:07:36 -0500
From: Rob Herring <robh@kernel.org>
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Cristina Opriceana <cristina.opriceana@gmail.com>,
	Varka Bhadram <varkabhadram@gmail.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [RFC PATCH v1 2/3] iio:ak8975: add mounting matrix support
Message-ID: <20160411190736.GA11591@rob-hp-laptop>
References: <cover.1460113510.git.gregor.boirie@parrot.com>
 <443cbafb38dc5ce38cbb7753aa6a4230d7188df9.1460113510.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <443cbafb38dc5ce38cbb7753aa6a4230d7188df9.1460113510.git.gregor.boirie@parrot.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Apr 08, 2016 at 04:12:04PM +0200, Gregor Boirie wrote:
> Expose a rotation matrix to indicate userspace the chip orientation with
> respect to the overall hardware system.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> ---
>  .../bindings/iio/magnetometer/ak8975.txt           | 10 ++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/magnetometer/ak8975.c                  | 40 ++++++++++++++++++++--
>  include/linux/iio/magnetometer/ak8975.h            | 16 +++++++++
>  3 files changed, 64 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/iio/magnetometer/ak8975.h
