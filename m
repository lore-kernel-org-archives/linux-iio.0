Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:52420 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab2JELfB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Oct 2012 07:35:01 -0400
Message-ID: <506EC5F2.1000300@jic23.retrosnub.co.uk>
Date: Fri, 05 Oct 2012 12:35:14 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: Querry on IIO/ADC DT based consumer device probe
References: <CAHfPSqCnBw1ed97greGdMz-qexWbB2b5_NrbT6FFUeawvygWWg@mail.gmail.com>
In-Reply-To: <CAHfPSqCnBw1ed97greGdMz-qexWbB2b5_NrbT6FFUeawvygWWg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/10/12 10:07, Naveen Krishna Ch wrote:
> Hello All,
>
> I'm trying to add an ADC driver under IIO/ADC.
> Machine is DT based so, passing the ADC device as tree node and
> consumer devices (thermistors) as child nodes via DT.
>
> I don't find a frame work to parse the child nodes and probe them like
> I2C does using of/of_i2c.c
>
> The DT snippet:
>         adc@12D10000 {
>                  thermistor@3 {
>                          compatible = "ntc,ncp15wb473";
>                          consumer-name = "ntc,ncp15wb473";
>                          consumer-channel = "adc-3";
>                          pullup-uV = <1800000>;
>                          pullup-ohm = <47000>;
>                          pulldown-ohm = <0>;
>                          connected-positive;
>                  };
>
>                  thermistor@4 {
>                          compatible = "ntc,ncp15wb473";
>                          consumer-name = "ntc,ncp15wb473";
>                          consumer-channel = "adc-4";
>                          pullup-uV = <1800000>;
>                          pullup-ohm = <47000>;
>                          pulldown-ohm = <0>;
>                          connected-positive;
>                  };
>      };
>
> Parsing snippet:
>   for_each_child_of_node(node, client_node) {
>                  char *channel, *label = NULL;
>
>                  if (of_property_read_string(client_node,
> "consumer-channel", &channel) != 0) {
>                          dev_err(&pdev->dev, "Missing consumer-channel
> property in the DT.\n");
>                          return -EINVAL;
>                  }
>
>                  client_map[i].consumer_channel = channel;
>                  label = "lable-adc";      //TODO
>                  client_map[i].adc_channel_label = label;
>
>
>                  if (of_property_read_string(client_node,
> "consumer-name", &client_map[i].consumer_dev_name) != 0) {
>                          dev_err(&pdev->dev, "Missing consumer-name
> property in the DT.\n");
>                          return -EINVAL;
>                  }
>
>                  i++;
>          }
>
> Can some one suggest a way to get the consumer thermistor driver to
> get probed from iio framework via DT.
> Kindly, point me towards any existing framework to do the same.

Sorry, I don't think anyone has implemented a device tree version yet.
Just comes down to no one until you having needed it. Feel free to
send patches!

